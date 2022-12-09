class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase_destination , only: [:index, :new]
  before_action :set_item
  before_action :set_card

  def index
    redirect_to root_path if @item.user == current_user || !@item.purchase.nil?
  end

  def new
  end

  def create
    redirect_to new_card_path and return unless current_user.card.present?
    @purchase_destination = PurchaseDestination.new(purchase_params)
    if @purchase_destination.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        customer: customer_token, # 顧客のトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @purchase_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_destination).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id])
  end

  def set_purchase_destination
    @purchase_destination = PurchaseDestination.new
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_card
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
  end

end
