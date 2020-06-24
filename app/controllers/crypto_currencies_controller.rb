class CryptoCurrenciesController < ApplicationController
  COINS = %w[BTC ETH BCH LTC EOS].freeze

  def prices
    set_coins
  end

  private

  def set_coins
    @coins_prices = CurrecyPriceService.instance.coin_price currencies: COINS
  end
end
