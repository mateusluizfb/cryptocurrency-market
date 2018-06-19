class OrdersController < ApplicationController
  COINS = %w[BTC ETH BCH LTC EOS].freeze

  def new
    @order = Order.new
    @coins_prices = CurrecyPriceService.instance.coin_price currencies: COINS
  end

  def create
    head :created
  end
end
