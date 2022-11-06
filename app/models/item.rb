class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

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
  end

  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'invalid. Input half-width characters' }                  
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  with_options presence: true, numericality: { other_than: 1 , message: "can't be blank"}  do   
    validates :category_id
    validates :item_status_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :delivery_date_id
  end
end
