class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card
  before_action :redirect, only: [:update, :destroy]

  def new
    @card = Card.new
  end
  
  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  
    if params['card_token'].blank?
      redirect_to action: 'new'
    else
      customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )
      @card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id,
      user_id: current_user.id
    )
      @card.save
      redirect_to root_path
    end
  end

  def show
    redirect_to action:'new' && return unless @card.present?
    customer = Payjp::Customer.retrieve(@card.customer_token)
    @card = customer.cards.first
  end

  def destroy
    customer = Payjp::Customer.retrieve(@card.customer_token)
    customer.delete

    redirect_to action:'new' if @card.destroy
  end

  private
  def set_card
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    @card = Card.find_by(user_id: current_user.id)
  end

  # def redirect
  #   redirect_to action: :new unless current_user.id == @card.user.id
  # end

 end
 
