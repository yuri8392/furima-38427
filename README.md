#テーブル設計

## Usersテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| nickname            | string     | null: false                    |
| email               | string     | null: false, unique: true      |
| encrypted_password  | string     | null: false                    |
| last_name           | string     | null: false                    |
| first_name          | string     | null: false                    |
| last_name_kana      | string     | null: false                    |
| first_name_kana     | string     | null: false                    |
| birthday            | date       | null: false                    |

### Association

- has_many :items, dependent: :destroy
- belongs_to :destination ,dependent: :destroy
- has_one :purchase ,dependent: :destroy

## itemsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| image               | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | references | null: false, foreign_key: true |
| price               | integer    | null: false                    |
| item_status         | integer    | null: false                    |
| delivery_charge     | string     | null: false                    |
| prefecture_id       | references | null: false, foreign_key: true |
| delivery_date       | string     | null: false                    |
| user_id             | references | null: false, foreign_key: true |

### Association

- belongs_to :user, dependent: :destroy
- belongs_to :category, dependent: :destroy
- belongs_to_active_hash :prefecture

## categoryテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |

### Association

- has_many: items

## purchaseテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user_id             | references | null: false, foreign_key: true |
| card_id             | string     | null: false                    |

### Association

- belongs_to :user
- has_one :destination ,dependent: :destroy

## destinationテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user_id             | references | null: false, foreign_key: true |
| last_name           | string     | null: false                    |
| first_name          | string     | null: false                    |
| last_name_kana      | string     | null: false                    |
| first_name_kana     | string     | null: false                    |
| post_code           | string     | null: false                    |
| prefecture          | integer    | null: false                    |
| city                | string     | null: false                    |
| address             | string     | null: false                    |
| buiding_name        | string     |                                |
| phone_number        | string     | null: false                    |

### Association

- belongs_to :purchase
