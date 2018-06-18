class CurrecyPriceService
  include Singleton

  def initialize
    @headers = {"Content-Type" => "application/json"}
  end

  def coin_price(currencies:)
    currencies_string = currencies.join(",")
    url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/price?fsym=#{currencies_string}&tsyms=USD"
    HTTParty.get(url, headers: @headers)
  end
end
