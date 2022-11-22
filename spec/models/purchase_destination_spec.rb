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
        expect(@purchase_destination.errors.full_messages).to include 'クレジットカード情報を入力してください'
      end
      it '郵便番号が空では購入できない' do
        @purchase_destination.post_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '郵便番号を入力してください'
      end
      it '郵便番号が「3桁ハイフン4桁」の半角文字列以外では購入できない' do
        @purchase_destination.post_code = 1_234_567
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '郵便番号は３桁-４桁で入力してください'
      end
      it '都道府県が空では購入できない' do
        @purchase_destination.prefecture_id = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '都道府県を入力してください'
      end
      it '都道府県が---だと購入できない' do
        @purchase_destination.prefecture_id = 1
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '都道府県を入力してください'
      end
      it '市区町村が空だと購入できない' do
        @purchase_destination.city = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '市区町村を入力してください'
      end
      it '番地が空だと購入できない' do
        @purchase_destination.address = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '番地を入力してください'
      end
      it '電話番号が空だと購入できない' do
        @purchase_destination.phone_number = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '電話番号を入力してください'
      end
      it '電話番号が9桁以下の半角数値だと購入できない' do
        @purchase_destination.phone_number = 123_456_789
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '電話番号は半角数字で10もしくは11桁で入力してください'
      end
      it '電話番号が12桁以上の半角数値だと購入できない' do
        @purchase_destination.phone_number = 123_456_789_012
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '電話番号は半角数字で10もしくは11桁で入力してください'
      end
      it '電話番号が半角数字以外だと購入できない' do
        @purchase_destination.phone_number = '090-1111-1111'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include '電話番号はハイフンを除いて数字のみで入力してください'
      end
      it 'userが紐付いていないと保存できない' do
        @purchase_destination.user_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('ユーザーを入力してください')
      end
      it 'itemが紐付いていないと保存できない' do
        @purchase_destination.item_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('商品情報を入力してください')
      end
    end
  end
end
