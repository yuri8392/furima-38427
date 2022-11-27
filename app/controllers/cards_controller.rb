class CardsController < ApplicationController
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
  
 end
 
