class CryptoCurrenciesController < ApplicationController
  COINS = %w[BTC ETH BCH LTC EOS].freeze

  def prices
    @coins_prices = CurrecyPriceService.instance.coin_price currencies: COINS
  end
end
