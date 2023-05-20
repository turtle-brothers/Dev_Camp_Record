# インターネットTV

## ステップ1：テーブル設計

<details>
<summary>1. エンティティ</summary>
<p>

- エピソード

- シーズン

- 番組

- タイムスロット

- チャンネル

- 番組ジャンル

- ジャンル

</p>
</details>

<details>
<summary>2. テーブル設計</summary>
<p>

[エピソード]
- エピソードID
- エピソード番号(数)
- タイトル
- エピソード詳細
- 動画時間
- 公開日
- 視聴数
- シーズンID
- 番組ID

    プライマリーキー：エピソードID

    外部キー：シーズンID、番組ID

[シーズン]
- シーズンID
- シーズン番号(数)

    プライマリーキー：シーズンID

    外部キー：番組ID

[番組]
- 番組ID
- タイトル
- 番組詳細

    プライマリーキー：番組ID

[タイムスロット]
- タイムスロットID
- 開始時刻(日付+時間)
- 終了時刻(日付+時間)
- チャンネルID

    プライマリーキー：タイムスロットID

    外部キー：エピソードID, チャンネルID

[チャンネル]
- チャンネルID
- チャンネル

    プライマリーキー：チャンネルID

[番組ジャンル]
- 番組ID
- ジャンルID

    プライマリーキー：番組ID、ジャンルID

    外部キー：番組ID、ジャンルID

[ジャンル]
- ジャンルID
- ジャンル

    プライマリーキー：ジャンルID

</p>
</details>

<details>
<summary>3. ER図</summary>
<p>
![ER_diagram](https://github.com/turtle-brothers/Dev_Camp_Record/assets/62471053/4fc99665-c7b9-459b-9cf4-5edad0ad0367)

</p>
</details>

<details>
<summary>4. テーブル定義</summary>
<p>

テーブル：episodes

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|episode_id|INT|NO|PRIMARY|NULL|YES|
|season_id|INT|NO|FOREIGN|NULL|NO|
|program_id|INT|NO|FOREIGN|NULL|NO|
|episode_number|INT|NO|NULL|NULL|NO|
|episode_title|VARCHAR(255)|NO|NULL|NULL|NO|
|episode_detail|TEXT|NO|NULL|NULL|NO|
|video_time|TIME|NO|NULL|NULL|NO|
|release_date|DATE|NO|NULL|NULL|NO|
|views|INT|NO|NULL|NULL|NO|
|外部キー制約：season_id, program_id||||||


テーブル：seasons

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|season_id|INT|NO|PRIMARY|NULL|YES|
|season_number|INT|NO|NULL|NULL|NO|
|program_id|INT|NO|FOREIGN|NULL|NO|
|外部キー制約：program_id||||||


テーブル：programs

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|program_id|INT|NO|PRIMARY|NULL|YES|
|program_title|VARCHAR(255)|NO|NULL|NULL|NO|
|program_detail|text|NO|NULL|NULL|NO|


テーブル：time_slots

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|time_slot_id|INT|NO|PRIMARY|NULL|YES|
|channel_id|INT|NO|FOREIGN|NULL|NO|
|start_time|TIME|NO|NULL|NULL|NO|
|end_time|TIME|NO|NULL|NULL|NO|
|外部キー制約：channel_id, episode_id||||||


テーブル：channels

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|channel_id|INT|NO|PRIMARY|NULL|YES|
|channel_name|VARCHAR(255)|NO|NULL|NULL|NO|


テーブル：program_genres

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|program_id|INT|NO|PRIMARY|NULL|YES|
|genre_id|INT|NO|PRIMARY|NULL|YES|
|program_id|INT|NO|FOREIGN|NULL|NO|
|genre_id|INT|NO|FOREIGN|NULL|NO|
|外部キー制約：program_id, genre_id||||||


テーブル：genres

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|genre_id|INT|NO|PRIMARY|NULL|YES|
|genre_name|VARCHAR(255)|NO|NULL|NULL|NO|

</p>
</details>



## ステップ2：データベース・テーブル構築とデータ入力の手順

Dockerを使用する事を前提としています。

Dockerがインストールされていない場合は、インストールしてから実行下さい。

<details>
<summary>0. データをコピーする</summary>
<p>

Dockerを起動する

```docker-compose up -d```

GitHubから任意のディレクトリへデータをコピーする

　```cd 任意のディレクトリ```
<br>
```git clone https://github.com/turtle-brothers/Dev_Camp_Record.git```
<br>
```cd ./Dev_Camp_Record/week_5-6/practise/```

</p>
</details>


<details>
<summary>1. mysqlの中に入る</summary>
<p>

データをmysqlサーバーに入れる

```docker cp ../Quest データベース名:/tmp/Quest```

Dockerコンテナの中に入る

```docker-compose exec mysql bash```

データをコピーしたディレクトリへ移動する

```cd /tmp/Quest```

mysqlの中に入る

```mysql -u root -p${MYSQL_PASSWORD} ${MYSQL_DATABASE}```

</p>
</details>

<details>
<summary>2. データベースを作成する</summary>
<p>

データベースの表示

```SHOW DATABASES;```

データベースの作成

```CREATE DATABASE tvs;```

作成されたかどうか確認

```SHOW DATABASES;```

```sql
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| tvs                |
+--------------------+
5 rows in set (0.22 sec)

```

データベースの指定

```USE tvs;```

指定しているデータベースの確認

```SELECT DATABASE();```

```sql
+-------------+
| database()  |
+-------------+
| tvs |
+-------------+
1 row in set (0.00 sec)
```

</p>
</details>

<details>
<summary>3. テーブルを作成する</summary>
<p>

テーブルの作成
(CREATE TABLE文・ALTER文ごと(；区切り)にコピーして、mysqlのターミナルに貼り付け)

```sql
CREATE TABLE genres(
    genre_id    INT          NOT NULL AUTO_INCREMENT,
    genre_name  VARCHAR(255) NOT NULL,
    PRIMARY KEY (genre_id)
);

CREATE TABLE channels(
    channel_id    INT          NOT NULL AUTO_INCREMENT,
    channel_name  VARCHAR(255) NOT NULL,
    PRIMARY KEY (channel_id)
);

CREATE TABLE programs(
    program_id      INT          NOT NULL AUTO_INCREMENT,
    program_title   VARCHAR(255) NOT NULL,
    program_detail  TEXT         NOT NULL,
    PRIMARY KEY (program_id)
);

CREATE TABLE program_genres(
    program_id  INT NOT NULL,
    genre_id    INT NOT NULL,
    FOREIGN KEY (program_id) REFERENCES programs(program_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

ALTER TABLE program_genres ADD PRIMARY KEY(program_id, genre_id);

CREATE TABLE seasons(
    season_id       INT NOT NULL AUTO_INCREMENT,
    season_number   INT NOT NULL,
    program_id      INT NOT NULL,
    PRIMARY KEY (season_id),
    FOREIGN KEY (program_id) REFERENCES programs(program_id)
);


CREATE TABLE episodes(
    episode_id      INT          NOT NULL AUTO_INCREMENT,
    season_id       INT          NOT NULL,
    program_id      INT          NOT NULL,
    episode_number  INT          NOT NULL,
    episode_title   VARCHAR(255) NOT NULL,
    episode_detail  TEXT         NOT NULL,
    video_time      TIME         NOT NULL,
    release_date    DATE         NOT NULL,
    views           INT          NOT NULL,
    PRIMARY KEY (episode_id),
    FOREIGN KEY (season_id) REFERENCES seasons(season_id),
    FOREIGN KEY (program_id) REFERENCES programs(program_id)
);

CREATE TABLE time_slots(
    time_slot_id  INT  NOT NULL AUTO_INCREMENT,
    channel_id    INT  NOT NULL,
    start_time    TIME NOT NULL,
    end_time      TIME NOT NULL,
    episode_id    INT  NOT NULL,
    PRIMARY KEY (time_slot_id),
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id),
    FOREIGN KEY (episode_id) REFERENCES episodes(episode_id)
);

```

作成されたか確認。

```SHOW TABLES;```

```sql
mysql> SHOW TABLES;
+-----------------+
| Tables_in_tvs   |
+-----------------+
| channels        |
| episodes        |
| genres          |
| program_genres  |
| programs        |
| seasons         |
| time_slots      |
+-----------------+
7 rows in set (0.01 sec)
```

</p>
</details>

<details>
<summary>4. テーブルにデータを入れる</summary>
<p>

<details>
<summary>channelsテーブル</summary>
<p>
mysqlの中から実行

```source insert_channels.sql;```

```sql
source insert_channels.sql
Query OK, 16 rows affected (0.03 sec)
Records: 16  Duplicates: 0  Warnings: 0
```

データが入力されたか確認

```SELECT * FROM channel_table;```

```sql
mysql> SELECT * FROM channels;
+------------+-----------------+
| channel_id | channel_name    |
+------------+-----------------+
|          1 | dorama          |
|          2 | NHK_General     |
|          3 | NHK_Educational |
|          4 | Nippon_TV       |
|          5 | TBS             |
|          6 | Fuji_TV         |
|          7 | TV_Asahi        |
|          8 | TV_Tokyo        |
|          9 | Tokyo_MX        |
|         10 | BS_TBS          |
|         11 | BS_Fuji         |
|         12 | BS_Nippon       |
|         13 | BS_Asahi        |
|         14 | BS_Japan        |
|         15 | BS_TV_Tokyo     |
|         16 | BS11            |
+------------+-----------------+
16 rows in set (0.00 sec)
```
</p>
</details>

<details>
<summary>genresテーブル</summary>
<p>
mysqlの中から実行

```source insert_genres.sql;```

```sql
mysql> source insert_genres.sql;
Query OK, 29 rows affected (0.06 sec)
Records: 29  Duplicates: 0  Warnings: 0
```

データが入力されたか確認

```SELECT * FROM genres;```

```sql
mysql> SELECT * FROM genres;
+----------+-----------------+
| genre_id | genre_name      |
+----------+-----------------+
|        1 | Drama           |
|        2 | Comedy          |
|        3 | Action          |
|        4 | Romance         |
|        5 | Thriller        |
|        6 | Mystery         |
|        7 | Fantasy         |
|        8 | Science_Fiction |
|        9 | Horror          |
|       10 | Adventure       |
|       11 | Animation       |
|       12 | Crime           |
|       13 | Documentary     |
|       14 | Reality_TV      |
|       15 | Game_Show       |
|       16 | Talk_Show       |
|       17 | Variety_Show    |
|       18 | Sports          |
|       19 | News            |
|       20 | Music           |
|       21 | Historical      |
|       22 | Supernatural    |
|       23 | Family          |
|       24 | Western         |
|       25 | Cooking         |
|       26 | Travel          |
|       27 | Human_drama     |
|       28 | Educational     |
|       29 | Fashion         |
+----------+-----------------+
29 rows in set (0.01 sec)
```
</p>
</details>

<details>
<summary>programsテーブル</summary>
<p>
mysqlの中から実行

```source insert_programs.sql;```

```sql
mysql> source insert_programs.sql;
Query OK, 29 rows affected (0.03 sec)
Records: 29  Duplicates: 0  Warnings: 0
```

データが入力されたか確認

```SELECT * FROM programs;```

```sql
mysql> SELECT * FROM programs;
+------------+-------------------------+-----------------------------------------------------------------------------------------------+
| program_id | program_title           | program_detail
                                           |
+------------+-------------------------+-----------------------------------------------------------------------------------------------+
|          1 | Comedy Central          | Laugh out loud with the best comedy sketches and stand-up performances.                       |
|          2 | Action Unlimited        | Non-stop adrenaline-pumping action movies and TV series.                                      |
|          3 | Romantic Escapes        | Join us as we explore the most beautiful and romantic destinations around the globe.          |
|          4 | Mystery Files           | Delve into unsolved mysteries and intriguing crime cases with expert investigators.           |
|          5 | Science World           | Discover the wonders of science through exciting experiments and fascinating documentaries.   |
|          6 | Horror Nightmares       | Get ready for a spine-chilling night of horror movies that will leave you terrified.          |
|          7 | Adventure Quest         | Embark on thrilling adventures in the wilderness and uncover hidden treasures.                |
|          8 | Animation Mania         | Enjoy a marathon of your favorite animated shows and movies for all ages.                     |
|          9 | Crime Watch             | Stay updated on the latest crime news and investigations happening in your city.              |
|         10 | Travel Diaries          | Join our hosts as they explore breathtaking destinations and share their travel experiences.  |
|         11 | Documentary Showcase    | Experience captivating documentaries that cover a wide range of subjects and issues.          |
|         12 | Reality TV Showdown     | Witness intense competitions and dramatic moments in the world of reality television.         |
|         13 | Game Show Extravaganza  | Test your knowledge and skills as contestants battle it out for fantastic prizes.             |
|         14 | Talk Show Live          | Engage in thought-provoking discussions and interviews with renowned guests.                  |
|         15 | Variety Funhouse        | Be entertained with a mix of music, comedy, and exciting performances.                        |
|         16 | Sports Unlimited        | Catch all the thrilling sports action and highlights from around the world.                   |
|         17 | World News Tonight      | Stay informed with comprehensive coverage of the day top news stories.                        |
|         18 | Music Fusion            | Experience a fusion of different music genres and performances from talented artists.         |
|         19 | Fashion Forward         | Explore the latest trends, styles, and fashion tips from the world of haute couture.          |
|         20 | Historical Journey      | Take a journey through time as we delve into significant historical events and figures.       |
|         21 | Supernatural Encounters | Explore the world of the supernatural and paranormal with firsthand accounts.                 |
|         22 | Family Fun Time         | Enjoy quality family programming with wholesome shows and entertainment.                      |
|         23 | Western Classics        | Relive the golden era of Western movies and TV series featuring iconic cowboys.               |
|         24 | Sci-Fi Spectacular      | Immerse yourself in the world of futuristic technology and thrilling science fiction.         |
|         25 | Culinary Delights       | Indulge in mouthwatering recipes, culinary adventures, and gourmet delights.                  |
|         26 | Globe Trekker           | Embark on unforgettable journeys to exotic locations and experience different cultures.       |
|         27 | Educational Explorers   | Learn fascinating facts and expand your knowledge through educational programming.            |
|         28 | Musical Melodies        | Get lost in a melodic journey with enchanting music performances and live concerts.           |
|         29 | Fashion Runway          | Witness the glamour and creativity of fashion as models strut the runway in stunning designs. |
+------------+-------------------------+-----------------------------------------------------------------------------------------------+
29 rows in set (0.01 sec)
```
</p>
</details>


<details>
<summary>seasonsテーブル</summary>
<p>
mysqlの中から実行

```source insert_seasons.sql;```

```sql
mysql> source insert_seasons.sql;
Query OK, 30 rows affected (0.03 sec)
Records: 30  Duplicates: 0  Warnings: 0
```

データが入力されたか確認

```SELECT * FROM seasons;```

```sql
mysql> SELECT * FROM seasons;
+-----------+---------------+------------+
| season_id | season_number | program_id |
+-----------+---------------+------------+
|         1 |             1 |         25 |
|         2 |             6 |          3 |
|         3 |             4 |          6 |
|         4 |             5 |         17 |
|         5 |             6 |         28 |
|         6 |             7 |         18 |
|         7 |             5 |         20 |
|         8 |             7 |         27 |
|         9 |             6 |         22 |
|        10 |             5 |         24 |
|        11 |             8 |         21 |
|        12 |             4 |         16 |
|        13 |             4 |          4 |
|        14 |             7 |          3 |
|        15 |             7 |          4 |
|        16 |             1 |         10 |
|        17 |             3 |          9 |
|        18 |             9 |          2 |
|        19 |             2 |         22 |
|        20 |            10 |         12 |
|        21 |            11 |          3 |
|        22 |             3 |         18 |
|        23 |             4 |         28 |
|        24 |             6 |         18 |
|        25 |             6 |         14 |
|        26 |             3 |          5 |
|        27 |             4 |         17 |
|        28 |             2 |         23 |
|        29 |             8 |          8 |
|        30 |             7 |          4 |
+-----------+---------------+------------+
30 rows in set (0.01 sec)
```
</p>
</details>

<details>
<summary>time_slotsテーブル</summary>
<p>
mysqlの中から実行

```source insert_time_slots.sql;```

```sql
mysql> source insert_time_slots.sql;
Query OK, 48 rows affected, 96 warnings (0.02 sec)
Records: 48  Duplicates: 0  Warnings: 96
```

データが入力されたか確認

```SELECT * FROM time_slots;```

```sql
mysql> SELECT * FROM time_slots;
+--------------+------------+------------+----------+------------+
| time_slot_id | channel_id | start_time | end_time | episode_id |
+--------------+------------+------------+----------+------------+
|            1 |          1 | 00:00:00   | 00:30:00 |          1 |
|            2 |          2 | 00:30:00   | 01:00:00 |          2 |
|            3 |          3 | 01:00:00   | 01:30:00 |          3 |
|            4 |          4 | 01:30:00   | 02:00:00 |          4 |
|            5 |          5 | 02:00:00   | 02:30:00 |          5 |
|            6 |          6 | 02:30:00   | 03:00:00 |          6 |
|            7 |          7 | 03:00:00   | 03:30:00 |          7 |
|            8 |          8 | 03:30:00   | 04:00:00 |          8 |
|            9 |          9 | 04:00:00   | 04:30:00 |          9 |
|           10 |         10 | 04:30:00   | 05:00:00 |         10 |
|           11 |          1 | 05:00:00   | 05:30:00 |          1 |
|           12 |          2 | 05:30:00   | 06:00:00 |          2 |
|           13 |          3 | 06:00:00   | 06:30:00 |          3 |
|           14 |          4 | 06:30:00   | 07:00:00 |          4 |
|           15 |          5 | 07:00:00   | 07:30:00 |          5 |
|           16 |          6 | 07:30:00   | 08:00:00 |          6 |
|           17 |          7 | 08:00:00   | 08:30:00 |          7 |
|           18 |          8 | 08:30:00   | 09:00:00 |          8 |
|           19 |          9 | 09:00:00   | 09:30:00 |          9 |
|           20 |         10 | 09:30:00   | 10:00:00 |         10 |
|           21 |          1 | 10:00:00   | 10:30:00 |          1 |
|           22 |          2 | 10:30:00   | 11:00:00 |          2 |
|           23 |          3 | 11:00:00   | 11:30:00 |          3 |
|           24 |          4 | 11:30:00   | 12:00:00 |          4 |
|           25 |          5 | 12:00:00   | 12:30:00 |          5 |
|           26 |          6 | 12:30:00   | 13:00:00 |          6 |
|           27 |          7 | 13:00:00   | 13:30:00 |          7 |
|           28 |          8 | 13:30:00   | 14:00:00 |          8 |
|           29 |          9 | 14:00:00   | 14:30:00 |          9 |
|           30 |         10 | 14:30:00   | 15:00:00 |         10 |
|           31 |          1 | 15:00:00   | 15:30:00 |          1 |
|           32 |          2 | 15:30:00   | 16:00:00 |          2 |
|           33 |          3 | 16:00:00   | 16:30:00 |          3 |
|           34 |          4 | 16:30:00   | 17:00:00 |          4 |
|           35 |          5 | 17:00:00   | 17:30:00 |          5 |
|           36 |          6 | 17:30:00   | 18:00:00 |          6 |
|           37 |          7 | 18:00:00   | 18:30:00 |          7 |
|           38 |          8 | 18:30:00   | 19:00:00 |          8 |
|           39 |          9 | 19:00:00   | 19:30:00 |          9 |
|           40 |         10 | 19:30:00   | 20:00:00 |         10 |
|           41 |          1 | 20:00:00   | 20:30:00 |          1 |
|           42 |          2 | 20:30:00   | 21:00:00 |          2 |
|           43 |          3 | 21:00:00   | 21:30:00 |          3 |
|           44 |          4 | 21:30:00   | 22:00:00 |          4 |
|           45 |          5 | 22:00:00   | 22:30:00 |          5 |
|           46 |          6 | 22:30:00   | 23:00:00 |          6 |
|           47 |          7 | 23:00:00   | 23:30:00 |          7 |
|           48 |          8 | 23:30:00   | 00:00:00 |          8 |
+--------------+------------+------------+----------+------------+
48 rows in set (0.00 sec)

```
</p>
</details>

<details>
<summary>episodesテーブル</summary>
<p>
mysqlの中から実行

```source insert_episodes.sql;```

```sql
mysql> source insert_episode_viewers.sql;
Query OK, 30 rows affected (0.02 sec)
Records: 30  Duplicates: 0  Warnings: 0
```

データが入力されたか確認

```SELECT * FROM episodes;```

```sql
mysql> SELECT * FROM episodes;
+------------+-----------+------------+----------------+---------------------+--------------------------------------------------------------------------------+------------+--------------+-------+
| episode_id | season_id | program_id | episode_number | episode_title       | episode_detail                                                                 | video_time | release_date | views |
+------------+-----------+------------+----------------+---------------------+--------------------------------------------------------------------------------+------------+--------------+-------+
|          1 |         1 |          1 |              1 | The Beginning       | This is the first episode of our new show!                                     | 02:00:00   | 2023-05-15   |  1000 |
|          2 |         1 |          1 |              2 | Uncharted Territory | Our characters embark on an exciting adventure into unexplored lands.          | 00:45:00   | 2023-05-15   |  1500 |
|          3 |         1 |          1 |              3 | Secrets Revealed    | The mysteries surrounding our main characters are finally unveiled.            | 00:30:00   | 2023-05-15   |  1200 |
|          4 |         1 |          1 |              4 | Pilot Episode       | The first episode of our thrilling new series!                                 | 00:30:00   | 2023-05-16   |  2000 |
|          5 |         1 |          1 |              5 | Double Cross        | Betrayal and deceit take center stage in this intense episode.                 | 01:00:00   | 2023-05-16   |  1800 |
|          6 |         1 |          1 |              6 | The Chase Begins    | The protagonist embarks on a high-stakes chase to catch the culprits.          | 00:45:00   | 2023-05-16   |  1600 |
|          7 |         1 |          2 |              7 | New Horizons        | Our characters start a new chapter in their lives with exciting opportunities. | 00:30:00   | 2023-05-17   |   900 |
|          8 |         1 |          2 |              8 | Facing Fears        | Our protagonist confronts their deepest fears in a life-changing journey.      | 00:45:00   | 2023-05-17   |  1100 |
|          9 |         1 |          2 |              9 | Into the Unknown    | Our characters venture into uncharted territory, facing unexpected challenges. | 00:30:00   | 2023-05-17   |  1300 |
|         10 |         1 |          2 |             10 | The Origins         | Discover the origins of our main character in this intriguing episode.         | 01:00:00   | 2023-05-18   |  1700 |
|         11 |         1 |          2 |             11 | A Twist of Fate     | A surprising turn of events changes the course of our character lives.         | 01:00:00   | 2023-05-18   |  1900 |
|         12 |         1 |          2 |             12 | The Final Showdown  | The ultimate battle between good and evil reaches its climax.                  | 01:00:00   | 2023-05-18   |  2200 |
|         13 |         2 |          1 |             13 | The Awakening       | Our protagonist awakens to their true powers in this pivotal episode.          | 00:30:00   | 2023-05-19   |   950 |
|         14 |         2 |          1 |             14 | Hidden Secrets      | Dark secrets from the past resurface, threatening to unravel everything.       | 00:45:00   | 2023-05-19   |  1250 |
|         15 |         2 |          1 |             15 | Race Against Time   | Our characters race against the clock to prevent a catastrophic event.         | 01:00:00   | 2023-05-19   |  1450 |
+------------+-----------+------------+----------------+---------------------+--------------------------------------------------------------------------------+------------+--------------+-------+
15 rows in set (0.01 sec)
```
</p>
</details>



外部キー制約でデータが入力できない場合、一時的に外部キー制約を無効化して実行する必要がある。
データを入力した後に、再度外部キー制約を有効化することを忘れずに行う。

無効化

```SET FOREIGN_KEY_CHECKS=0;```

<details>
<summary>program_genresテーブル</summary>
<p>
mysqlの中から実行

```source insert_programs_genres.sql;```

```sql
mysql> source insert_programs_genres.sql;
Query OK, 30 rows affected (0.05 sec)
Records: 30  Duplicates: 0  Warnings: 0
```

データが入力されたか確認

```SELECT * FROM program_genres;```

```sql
mysql> SELECT * FROM program_genres;
+------------+----------+
| program_id | genre_id |
+------------+----------+
|          1 |        1 |
|         11 |        1 |
|         21 |        1 |
|          2 |        2 |
|         12 |        2 |
|         22 |        2 |
|          3 |        3 |
|         13 |        3 |
|         23 |        3 |
|          4 |        4 |
|         14 |        4 |
|         24 |        4 |
|          5 |        5 |
|         15 |        5 |
|         25 |        5 |
|          6 |        6 |
|         16 |        6 |
|         26 |        6 |
|          7 |        7 |
|         17 |        7 |
|         27 |        7 |
|          8 |        8 |
|         18 |        8 |
|         28 |        8 |
|          9 |        9 |
|         19 |        9 |
|         29 |        9 |
|         10 |       10 |
|         20 |       10 |
|         30 |       10 |
+------------+----------+
30 rows in set (0.00 sec)
```
</p>
</details>

有効化

```SET FOREIGN_KEY_CHECKS=1;```

外部キー制約の確認
```sql
mysql> SHOW VARIABLES LIKE 'FOREIGN_KEY_CHECKS';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| foreign_key_checks | ON    |
+--------------------+-------+
1 row in set (0.03 sec)
```

</p>
</details>

## ステップ3:データを抽出するクエリ

<details>
<summary>1. エピソード視聴数トップ3のエピソードタイトルと視聴数を取得する</summary>
<p>

```sql
SELECT episode_title, views
FROM episodes
ORDER BY views DESC
LIMIT 3;
```

</p>
</details>

<details>
<summary>2. エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得する</summary>
<p>

```sql
SELECT P.program_title, S.season_number, E.episode_number, E.episode_title, E.views
FROM episodes AS E
INNER JOIN seasons AS S
ON E.season_id = S.season_id
    INNER JOIN programs AS P
    ON E.program_id = P.program_id
ORDER BY views DESC
LIMIT 3;
```

</p>
</details>

<details>
<summary>3. 本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得する。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします</summary>
<p>

```sql
SELECT C.channel_name, CONCAT(CURDATE(), ' ', T.start_time) AS broadcast_start_time, CONCAT(CURDATE(), ' ', T.end_time) AS broadcast_end_time,
    S.season_number, E.episode_number, E.episode_title, E.episode_detail
FROM time_slots AS T
JOIN channels AS C
ON T.channel_id = C.channel_id
    JOIN episodes AS E
    ON T.start_time >= CURDATE() AND T.start_time < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
        JOIN programs AS P
        ON E.program_id = P.program_id
            LEFT JOIN seasons AS S
            ON E.season_id = S.season_id
WHERE DATE(E.release_date) = CURDATE()
ORDER BY C.channel_name, T.start_time;
```

</p>
</details>

<details>
<summary>4. ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得する</summary>
<p>

```sql
SELECT C.channel_name, CONCAT(DATE(E.release_date), ' ', T.start_time) AS broadcast_start_time, CONCAT(DATE(E.release_date), ' ', T.end_time) AS broadcast_end_time,
    S.season_number, E.episode_number, E.episode_title, E.episode_detail
FROM time_slots AS T
JOIN channels AS C
ON T.channel_id = C.channel_id
    JOIN episodes AS E
    ON T.start_time >= CURDATE() AND T.start_time < DATE_ADD(CURDATE(), INTERVAL 1 WEEK)
        JOIN programs AS P
        ON E.program_id = P.program_id
            LEFT JOIN seasons AS S
            ON E.season_id = S.season_id
WHERE DATE(E.release_date) BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 WEEK)
AND  C.channel_name = 'dorama'
ORDER BY E.release_date, T.start_time;
```

</p>
</details>

<details>
<summary>5. 直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得する</summary>
<p>

```sql
SELECT P.program_title, SUM(E.views) AS sum_view_count
FROM episodes AS E
JOIN programs AS P
ON E.program_id = P.program_id
WHERE DATE(E.release_date) BETWEEN (CURDATE() - INTERVAL 7 DAY) AND CURDATE()
GROUP BY P.program_title
ORDER BY sum_view_count DESC
LIMIT 2;
```

</p>
</details>

<details>
<summary>6. ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得する</summary>
<p>

```sql
SELECT genre_name, program_title, avg_view
FROM (
    SELECT G.genre_name, P.program_title, ROUND(AVG(views),0) AS avg_view, RANK() OVER (PARTITION BY G.genre_name ORDER BY AVG(E.views)) AS ranking
    FROM episodes AS E
    INNER JOIN programs AS P
    ON E.program_id = P.program_id
        INNER JOIN program_genres AS PG
        ON E.program_id = PG.program_id
            INNER JOIN genres AS G
            ON PG.genre_id = G.genre_id
    GROUP BY G.genre_name, P.program_id) AS views
WHERE ranking = 1;
```
</p>
</details>
