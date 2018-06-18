class CurrecyPriceService
  include Singleton

  def initialize
    @headers = {"Content-Type" => "application/json"}
  end

  def coin_price(currencies:)
    currencies_string = currencies.join(",")
    url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/pricemulti?fsyms=#{currencies_string}&tsyms=USD"
    parse_coin_prices HTTParty.get(url, headers: @headers).parsed_response
  end

  def dollar_to_coin(coin_value:, dollars:)
    (dollars / coin_value).round(4)
  end

  private

  def parse_coin_prices(prices)
    prices.map {|k, v| {coin_name: k, coin_price: v["USD"]} }
  end
end
