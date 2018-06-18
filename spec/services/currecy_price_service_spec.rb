require "rails_helper"

RSpec.describe CurrecyPriceService do
  describe "initialization" do
    it "can instantiate the singleton service" do
      expect(described_class.instance).to be_a CurrecyPriceService
    end
  end

  describe "#coin_price" do
    let(:headers) { {"Content-Type" => "application/json"} }

    it "should call the cryptocompare API" do
      url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/price?fsym=BTC&tsyms=USD"
      expect(HTTParty).to receive(:get).with(url, headers: headers)
      described_class.instance.coin_price(currencies: ["BTC"])
    end

    it "should call the cryptocompare API with the currencies received in the argument" do
      url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/price?fsym=BTC,ETH,BCH&tsyms=USD"
      expect(HTTParty).to receive(:get).with(url, headers: headers)
      described_class.instance.coin_price(currencies: ["BTC", "ETH", "BCH"])
    end
  end
end
