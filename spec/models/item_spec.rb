require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品が出品できるとき' do
      it '商品画像、商品名、説明、カテゴリー、商品状態、配送料負担、発送元地域、発送までの日数、価格が存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が出品できないとき' do
      it '商品画像が空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include '画像を入力してください'
      end
      it '商品名が空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '商品名を入力してください'
      end
      it '商品の説明が空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の説明を入力してください'
      end
      it 'カテゴリーが空だと出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include 'カテゴリーを入力してください'
      end
      it 'カテゴリーが---だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include 'カテゴリーを入力してください'
      end
      it '商品の状態が空だと出品できない' do
        @item.item_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の状態を入力してください'
      end
      it '商品の状態が---だと出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の状態を入力してください'
      end
      it '配送料の負担が空だと出品できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '配送料の負担を入力してください'
      end
      it '配送料の負担が---だと出品できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '配送料の負担を入力してください'
      end
      it '発送元の地域が空だと出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '発送元の地域を入力してください'
      end
      it '発送元の地域が---だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '発送元の地域を入力してください'
      end
      it '発送までの日数が空だと出品できない' do
        @item.delivery_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '発送までの日数を入力してください'
      end
      it '発送までの日数が---だと出品できない' do
        @item.delivery_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include '発送までの日数を入力してください'
      end
      it '価格が空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '金額を入力してください'
      end
      it '価格が全角だと出品できない' do
        @item.price = '１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include '金額は半角数字で入力してください'
      end
      it '価格が300円より低いと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include '金額は300〜9,999,999円の間で入力してください'
      end
      it '価格が9,999,999円より高いと出品できない' do
        @item.price = 11_111_111_299
        @item.valid?
        expect(@item.errors.full_messages).to include '金額は300〜9,999,999円の間で入力してください'
      end
      it 'ユーザーが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('ユーザーを入力してください')
      end
    end
  end
end
