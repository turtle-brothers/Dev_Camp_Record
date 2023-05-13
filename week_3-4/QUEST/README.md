# パスワードマネージャー
シェルスクリプトを使用して個人学習用に作成したパスワードを管理するパスワードマネージャーです。


## インストール方法・シェルスクリプト実行方法
ターミナル上で次のコマンドを実行して下さい。

git clone https://github.com/turtle-brothers/Dev_Camp_Record.git
<br>
cd ./Dev_Camp_Record/week_3-4/QUEST
<br>
chmod 775 ./password_manager.sh
<br>
./password_manager.sh

## 使い方
シェルスクリプトを実行すると、以下のメニューが表示されます。

パスワードマネージャーへようこそ！
<br>
次の選択肢から入力してください(Add Password/Get Password/Exit)：
<br>
Add Password が入力されると、サービス名、ユーザー名、パスワードの入力が求められ、入力された情報をファイルに保存して暗号化します。
<br>
Get Password が入力されると、サービス名の入力が求められ、入力されたサービスのサービス名、ユーザー名、パスワードが表示されます。
<br>
Exit が入力されると、プログラムが終了します。 Exit が入力されるまではプログラムは終了せず、「次の選択肢から入力してください(Add Password/Get Password/Exit)：」が繰り返されます。

▼アウトプット

パスワードマネージャーへようこそ！
次の選択肢から入力してください(Add Password/Get Password/Exit)：

### Add Password が入力された場合
サービス名を入力してください：
<br>
ユーザー名を入力してください：
<br>
パスワードを入力してください：

パスワードの追加に成功しました。
次の選択肢から入力してください(Add Password/Get Password/Exit)：

### Get Password が入力された場合
サービス名を入力してください：

#### サービス名が保存されていなかった場合
そのサービスは登録されていません。

#### サービス名が保存されていた場合
サービス名：hoge
<br>
ユーザー名：fuga
<br>
パスワード：piyo

次の選択肢から入力してください(Add Password/Get Password/Exit)：

### Exit が入力された場合
Thank you!
#### プログラムが終了

### Add Password/Get Password/Exit 以外が入力された場合
入力が間違っています。Add Password/Get Password/Exit から入力してください
