class OrdersController < ApplicationController
  COINS = %w[BTC ETH BCH LTC EOS].freeze

  def new
    @order = Order.new
    @coins_prices = CurrecyPriceService.instance.coin_price currencies: COINS
  end

  def create
    @order = Order.new order_params
    set_order_coin_data
    if !flash[:error] && @order.save
      redirect_to orders_path(email: @order.owner_email)
    else
      redirect_to new_order_path
    end
  end

  def index
    @orders = Order.by_email(params[:email]).all
  end

  private

  def set_order_coin_data
    amount = coin_amount_data(@order.dollar_value, params[:coin][:data])
    return flash[:error] = amount[:error] if amount[:error]
    @order.coin_name = amount[:coin_name]
    @order.coin_amount = amount[:coin_amount]
  end

  def coin_amount_data(dollars, coin_data)
    coin_name, coin_value = coin_data.split(":")
    unless CurrecyPriceService.instance.coin_price_consitent? coin_name: coin_name, price: coin_value.to_f
      return {error: "Coin current price is not updated or it's wrong"}
    end
    {
      coin_name:   coin_name,
      coin_amount: CurrecyPriceService.instance.dollar_to_coin(dollars: dollars, coin_value: coin_value.to_f)
    }
  end

  def order_params
    params.require(:order).permit(:owner_email, :coin_name, :dollar_value)
  end
end
