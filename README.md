## users テーブル

| Column             | Type   | Options                    |
|--------------------|--------|----------------------------|
| nickname           | string | null: false                |
| email              | string | null: false, unique: true  |
| encrypted_password | string | null: false                |
| last_name          | string | null: false                |
| first_name         | string | null: false                |
| last_name_kana     | string | null: false                |
| first_name_kana    | string | null: false                |
| birthday           | date   | null: false                | ※ dateは日付（年月日）扱うときに使う型


## Association
- has_many :items
- has_many :orders


## items テーブル
※ActiveHashではidを数値として持たせるからカラム型はintegerにする

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| name               | string     | null: false                    |
| description        | text       | null: false                    | ※ 商品説明
| category_id        | integer    | null: false                    | ※ 商品カテゴリ
| status_id          | integer    | null: false                    | ※ 商品状態
| delivery_fee_id    | integer    | null: false                    | ※ 配送料
| prefecture_id      | integer    | null: false                    | ※ 発送元都道府県
| shipping_day_id    | integer    | null: false                    | ※ 発送日数
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |


## Association
- belongs_to :user ※多 対 1 の関係（単数形にする）
- has_one :order   ※1 対 1 の関係（単数形にする）


## orders テーブル

| Column | Type       | Options                        |
|--------|------------|--------------------------------|
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

## Association
- belongs_to :user
- belongs_to :item ※orderとitemは1対1やけどitemが親やからbelong_toになる（itemがないとorderは存在できない）
- has_one :address


## addresses テーブル

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| postal_code     | string     | null: false                    | ※ 郵便番号
| prefecture_id   | integer    | null: false                    | ※ 都道府県
| city            | string     | null: false                    | ※ 市区町村
| house_number    | string     | null: false                    | ※ 番地
| building_name   | string     |                                | ※ 建物名
| phone_number    | string     | null: false                    | ※ 電話番号
| order           | references | null: false, foreign_key: true |

## Association
- belongs_to :order