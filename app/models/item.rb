class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :delivery_date

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :price
  end

  validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'は300〜9,999,999円の間で入力してください' }

  with_options presence: true, numericality: { other_than: 1, message: 'を入力してください' } do
    validates :category_id
    validates :item_status_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :delivery_date_id
  end
end
