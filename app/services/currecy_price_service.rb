class CurrecyPriceService
  include Singleton

  def coin_price
    url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/price?fsym=BTC&tsyms=USD"
    HTTParty.get(url, headers: {"Content-Type" => "application/json"})
  end
end
