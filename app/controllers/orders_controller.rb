class OrdersController < ApplicationController
  COINS = %w[BTC ETH BCH LTC EOS].freeze

  def new
    @order = Order.new
    @coins_prices = CurrecyPriceService.instance.coin_price currencies: COINS
  end

  def create
    @order = Order.new order_params
    @order.coin_amount = set_coin_amount(@order.dollar_value, @order.coin_name)
    @order.save
    head :created
  end

  private

  def set_coin_amount(dollars, coin_name)
    coins_prices = CurrecyPriceService.instance.coin_price currencies: [coin_name]
    CurrecyPriceService.instance.dollar_to_coin dollars: dollars, coin_value: coins_prices.first[:coin_price]
  end

  def order_params
    params.require(:order).permit(:owner_email, :coin_name, :dollar_value)
  end
end
