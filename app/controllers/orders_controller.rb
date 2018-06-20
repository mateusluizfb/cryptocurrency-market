class OrdersController < ApplicationController
  COINS = %w[BTC ETH BCH LTC EOS].freeze

  def new
    @order = Order.new
    @coins_prices = CurrecyPriceService.instance.coin_price currencies: COINS
  end

  def create
    @order = Order.new order_params
    amount = coin_amount_data(@order.dollar_value, params[:coin][:data])
    @order.coin_name = amount[:coin_name]
    @order.coin_amount = amount[:coin_amount]
    @order.save
    head :created
  end

  private

  def coin_amount_data(dollars, coin_data)
    coin_name, coin_value = coin_data.split(":")
    {
      coin_name:   coin_name,
      coin_amount: CurrecyPriceService.instance.dollar_to_coin(dollars: dollars, coin_value: coin_value.to_f)
    }
  end

  def order_params
    params.require(:order).permit(:owner_email, :coin_name, :dollar_value)
  end
end
