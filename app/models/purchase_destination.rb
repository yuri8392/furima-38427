class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :customer_token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は３桁-４桁で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を入力してください' }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'は半角数字で10もしくは11桁で入力してください' }
    validates :phone_number, numericality: { only_integer: true, message: 'はハイフンを除いて数字のみで入力してください' }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                       building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)  
  end
end
