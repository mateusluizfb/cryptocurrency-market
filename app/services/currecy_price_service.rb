class CurrecyPriceService
  include Singleton

  def initialize
    @headers = {"Content-Type" => "application/json"}
  end

  def coin_price(currencies:)
    currencies_string = currencies.join(",")
    url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/pricemulti?fsyms=#{currencies_string}&tsyms=USD"
    body = HTTParty.get(url, headers: @headers).parsed_response
    body.map {|k, v| {coin_name: k, coin_price: v["USD"]} }
  end
end
