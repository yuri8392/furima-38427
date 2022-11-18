require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_destination = FactoryBot.build(:purchase_destination, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品が購入できるとき' do
      it 'token,郵便番号、都道府県、市区町村、番地、電話番号があれば購入できる' do
        expect(@purchase_destination).to be_valid
      end
      it '建物名が空でも購入できる' do
        @purchase_destination.building_name = ''
        expect(@purchase_destination).to be_valid
      end
    end
    context '商品が購入できないとき' do
      it 'tokenが空では購入できない' do
        @purchase_destination.token = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include "Token can't be blank"
      end
      it '郵便番号が空では購入できない' do
        @purchase_destination.post_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include "Post code can't be blank"
      end
      it '郵便番号が「3桁ハイフン4桁」の半角文字列以外では購入できない' do
        @purchase_destination.post_code = 1_234_567
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include 'Post code is follows (e.g. 123-4567)'
      end
      it '都道府県が空では購入できない' do
        @purchase_destination.prefecture_id = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '都道府県が---だと購入できない' do
        @purchase_destination.prefecture_id = 1
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '市区町村が空だと購入できない' do
        @purchase_destination.city = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空だと購入できない' do
        @purchase_destination.address = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include "Address can't be blank"
      end
      it '電話番号が空だと購入できない' do
        @purchase_destination.phone_number = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include "Phone number can't be blank"
      end
      it '電話番号が9桁以下の半角数値だと購入できない' do
        @purchase_destination.phone_number = 123_456_789
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include 'Phone number please enter in 10 or 11 digits'
      end
      it '電話番号が12桁以上の半角数値だと購入できない' do
        @purchase_destination.phone_number = 123_456_789_012
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include 'Phone number please enter in 10 or 11 digits'
      end
      it '電話番号が半角数字以外だと購入できない' do
        @purchase_destination.phone_number = '090-1111-1111'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end
      it 'userが紐付いていないと保存できない' do
        @purchase_destination.user_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @purchase_destination.item_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
