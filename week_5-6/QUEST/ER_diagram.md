@startuml
エピソードテーブル }o--|| シーズンテーブル
エピソードテーブル }o--|| 番組テーブル
タイムスロットテーブル }o--|| チャンネルテーブル
番組ジャンルテーブル }o--|| 番組テーブル
番組ジャンルテーブル }o--|| ジャンルテーブル


class エピソードテーブル {
    {field}+エピソードID(PK)
    {field}エピソード番号
    {field}エピソードタイトル
    {field}エピソード詳細
    {field}動画時間
    {field}公開日
    {field}視聴数
    {method}-シーズンID(FK)
    {method}-番組ID(FK)
}
class シーズンテーブル {
    {field}+シーズンID(PK)
    {field}シーズン番号
    {method}-番組ID(FK)
}
class 番組テーブル {
    {field}+番組ID(PK)
    {field}タイトル
    {field}番組詳細
}
class タイムスロットテーブル {
    {field}+タイムスロットID(PK)
    {field}開始時刻
    {field}終了時刻
    {method}-チャンネルID(FK)
}
class チャンネルテーブル {
    {field}+チャンネルID(PK)
    {field}チャンネル
}
class 番組ジャンルテーブル {
    {field}+番組ID(PK)
    {field}+ジャンルID(PK)
    {method}-番組ID(FK)
    {method}-ジャンルID(FK)
}
class ジャンルテーブル {
    {field}+ジャンルID(PK)
    {field}ジャンル
}
@enduml
