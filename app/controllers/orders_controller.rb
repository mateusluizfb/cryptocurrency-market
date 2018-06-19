class OrdersController < ApplicationController
  COINS = %w[BTC ETH BCH LTC EOS].freeze

  def new
    @order = Order.new
    @coins_prices = CurrecyPriceService.instance.coin_price currencies: COINS
  end

  def create
    @order = Order.new params.require(:order).permit(:owner_email, :coin_name, :dollar_value)
    @order.coin_amount = 0
    @order.save
    head :created
  end

end
