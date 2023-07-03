#### RealWorld
Railsの個人学習用として、ブログプラットフォームを作る RealWorld という OSSを題材に学習しました。

Railsの環境構築からRealWorldのAPIのうち、Create Article、Get Article、Update Article、Delete Articleのエンドポイントを実装しました。

<details>
<summary><h4>Rails開発環境の準備</h4></summary>

下記の開発環境で実施しました。

##### 開発環境
- Edition: Windows 11 Home, Version: 22H2, OSビルド: 22621.1702
- WSL2
- Docker Desktop for Windows: 4.20.1 (110738)
- Docker Engine: 24.0.2
- Docker Compose: v2.18.1
- Ruby: 3.2.2
- Rails: 7.0.5
- MySQL: 8.0.33

次に、ディレクトリは下記の構成にしました。
ディレクトリ名は適宜変えて下さい。

##### ディレクトリ構成
real_world<br>
├realworld<br>
│├Gemfile<br>
│├Gemfile.lock<br>
│├entrypoint.sh<br>
│└Dockerfile<br>
└docker-compose.yml

各種設定ファイルを作成、記述していきます。
まずは、必要なディレクト・ファイルを作成します。

```terminal:console
mkdir real_world
cd real_world

mkdir realworld
touch docker-compose.yml

touch ./realworld/Gemfile
touch ./realworld/Gemfile.lock
touch ./realworld/entrypoint.sh
touch ./realworld/Dockerfile

```

次に、各ファイルを記述していきます。

##### Gemfile
```text:Gemfile
source 'https://rubygems.org'
gem 'rails', '~>7.0.5'
```
Railsは最新の7.0.5を使用しました。
Railsのバージョンは下記サイトから確認して下さい。

https://rubygems.org

##### Gemfile.lock
```text:Gemfile.lock
```
Gemfile.lockファイルはビルド後に、バージョン等の情報が記載されるので、現状は空ファイルのままで大丈夫です。

##### entrypoint.sh
```shell:entrypoint.sh
#!/bin/bash
set -e
rm -f /api/tmp/pids/server.pid
exec "$@"
```
Railsにはサーバー内にserver.pidというファイルが先に存在していたときに、サーバーが再起動できなくなる問題があります。それを回避するためのスクリプトを作成します。

##### Dockerfile
```dockerfile:Dockerfile
FROM ruby:latest
ARG RUBYGEMS_VERSION=3.4.6
RUN mkdir /api
WORKDIR /api
COPY Gemfile /api/Gemfile
COPY Gemfile.lock /api/Gemfile.lock
RUN gem update --system ${RUBYGEMS_VERSION} && \
    bundle install
COPY . /api
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
```
おおまかに内容を説明すると、イメージを指定した後にコンテナ内にapiというディレクトリを作成し、作業ディレクトリを指定しています。
次に、ローカルのGemfileとGemfile.lockをコンテナ内にコピーし、その後に、Gemをインストールします。
最後に、コンテナ起動時に実行するスクリプトをコピーし、実行権限を与えて、エンドポイントを設定。コンテナ起動時にRailsサーバが起動するようにしてあります。

##### docker-compose.yml
```yml:docker-compose.yml
version: '3'
services:
  api:
    build: ./realworld/
    command: /bin/sh -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - ./realworld:/api
    ports:
      - 3000:3000
    depends_on:
      - db
    tty: true
    stdin_open: true
  db:
    image: mysql:latest
    command: mysqld --character-set-server=utf8 --collation-server=utf8_unicode_ci
    volumes:
      - db-volume:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: password
      TZ: "Asia/Tokyo"
    ports:
      - "3306:3306"
volumes:
  db-volume:
```

おおまかに内容を説明すると、apiというサービス名を指定して、realworld配下のDockerfileを基にイメージをビルドしています。
volumesではローカルのrealworldディレクトリをコンテナ内のapiディレクトリにマウントしています。
depends_onでは、サービスの依存関係を指定しています。今回のように記述した場合、起動時には、db→apiの順に起動します。また、停止時には、api→dbの順に停止します。
また、dbサービスには最新のMySQLイメージを指定しています。
文字化け防止のために、utf8を指定しました。
volumesを記述するとコンテナを作り直したとしてもPCにデータを保存する領域が作成されるので今回はdb-volumesをボリュームしました。

##### docker compose run & build
```text:console
docker compose run api rails new . --force --database=mysql --api
docker compose build
```
apiモードでRailsプロジェクトを作成します。
docker compose runでは引数に指定したサービスのコンテナ内でコマンドを実行します。
api：docker-compose.ymlのservices直下のサービス名
--force：上書きオプション
--database=mysql：使用するデータベース
--api：APIモードの指定

Railsプロジェクトが作成できたら、イメージをビルドします。

##### データベース設定
```yml:./realworld/config/database.yml
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: password
  host: db
```
./realworld/config/database.ymlを編集します。
デフォルトではpasswordが空白、hostがlocalhostとなっているのでdocker上で設定した値に修正します。

##### データベースの作成
```text:console
docker compose up -d
docker compose exec api rails db:create
```
docker compose up -dでコンテナをバックグランドで実行。
docker compose exec api rails db:createでデータベースを作成しています。

##### コンテナ起動確認とRailsロゴの表示確認
```docker:console
docker-compose ps
NAME                IMAGE               COMMAND                  SERVICE             CREATED             STATUS
     PORTS
real_world-api-1    real_world-api      "entrypoint.sh /bin/…"   api                 34 hours ago        Up 10 minutes       0.0.0.0:3000->3000/tcp
real_world-db-1     mysql:latest        "docker-entrypoint.s…"   db                  34 hours ago        Up 10 minutes       0.0.0.0:3306->3306/tcp, 33060/tcp
```
docker-compose psコマンドでコンテナ情報を確認。
apiとdbが起動(up,running)している事が確認出来たら、下記のアドレスにアクセスしてみましょう。<br>
http://localhost:3000

Railsのロゴが表示されたら成功です。

##### CORS設定
忘れないうちにCORS設定をしておきます。
Gemfileに記載されている下記の部分のコメントアウトを解除します。

```text:Gemfile
gem "rack-cors"
```
コメントアウトして、gemが追加されたのでbundle installします。

```docker:console
docker compose exec api bundle install
```

config/initializers/cors.rbのRails.application.config.middleware.insert_before以下をコメントアウトします。
originsの部分はlocalhost:3000に置き換えて下さい。

```ruby:realworld/config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:3000"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```
</details>

<details>
<summary><h4>RealWorldのエンドポイント実装</h4></summary>

環境構築が出来たら、エンドポイントを作成する為、Model・Controller・ルートの設定をしていきます。

#### Model
Articleに必要なtitle, description, body, slugの型情報を記載し、マイグレーションを実行して、データベースにこの新しいテーブルを作成します。

```docker:console
rails generate model Article title:string description:text body:text slug:string
rails db:migrate
```

これでModelが作成されました。

#### Controller
次に、 ArticlesControllerを作成します。 このControllerは、記事の作成、取得、更新、削除を担当します。 Controllerを作成するには、次のコマンドを実行します。

```docker:console
rails generate controller Articles
```

作成したControllerに以下のアクションを追加します：

```ruby:controller.rb
class Api::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.slug = @article.title.parameterize

    if @article.save
      render json: { article: @article }, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # GET /articles/:slug
  def show
    render json: { article: @article }
  end

  # PATCH/PUT /articles/:slug
  def update
    if @article.update(article_params)
      render json: { article: @article }
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:slug
  def destroy
    @article.destroy
  end

  private
    def set_article
      @article = Article.find_by_slug!(params[:slug])
    end

    def article_params
      params.require(:article).permit(:title, :description, :body)
    end
end

```

#### Route
最後に、Routeに下記を追加する事で、アクションを有効にします。

```ruby:routes.rb
Rails.application.routes.draw do
  namespace :api do
    resources :articles, param: :slug, only: [:create, :show, :update, :destroy]
  end
end

```

</details>

<details>
<summary><h4>PostmanでAPI確認</h4></summary>
RealWorldのエンドポイントの実装が出来たら、PostmanでAPIをテストします。
下記のURLにアクセスしAPIをテスとしていきます。

https://web.postman.co/


POST, GET, PUT, DELETEそれぞれのアクションを実行するにあたり、下記に示すRealWorldの公式を参照します。

https://realworld-docs.netlify.app/docs/specs/backend-specs/endpoints/#get-article

なお、Article に関わる要素のうち、認証機能及び著者、タグ、お気に入り(favorite) は実装していません。

エンドポイント、HTTPリクエストに対して、HTTPレスポンス(200)が帰ってくればAPIテスト成功です。下記にそれぞれアクションのエンドポイント、HTTPリクエストに対して、HTTPレスポンスを示します。
エンドポイントにはAWS上のインフラにデプロイした下記を使用します。

https://dev-elb.zumens.jp


##### Create Article

- エンドポイント

https://dev-elb.zumens.jp/api/articles

- HTTPリクエスト
```text:body-raw-JSON
{
  "article": {
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "You have to believe"
  }
}
```

- HTTPレスポンス
```text:body-raw-JSON
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z"
    }
}
```

##### Get Article

- エンドポイント

https://dev-elb.zumens.jp/api/articles/:slug

- HTTPリクエスト
```text:body-raw-JSON
```

- HTTPレスポンス
```text:body-raw-JSON
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "How to train your dragon",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z"
    }
}
```
##### Update Article

- エンドポイント

https://dev-elb.zumens.jp/api/articles/:slug

- HTTPリクエスト
```text:body-raw-JSON
{
  "article": {
    "title": "Did you train your dragon?"
  }
}
```

- HTTPレスポンス
```text:body-raw-JSON
{
  "article": {
    "slug": "how-to-train-your-dragon",
    "title": "Did you train your dragon?",
    "description": "Ever wonder how?",
    "body": "It takes a Jacobian",
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z"
    }
}
```
##### Delete Article

- エンドポイント

https://dev-elb.zumens.jp/api/articles/:slug

- HTTPリクエスト
```text:body-raw-JSON
```

- HTTPレスポンス
```text:body-raw-JSON
```

</details>

<summary><h4>システム構成図</h4></summary>

![](./infra-stracture.svg)

</details>
