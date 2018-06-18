require "rails_helper"

RSpec.describe CurrecyPriceService do
  describe "initialization" do
    it "can instantiate the singleton service" do
      expect(described_class.instance).to be_a CurrecyPriceService
    end
  end

  describe "#coin_price" do
    let(:url) { "#{ENV['CRYPTO_COMPARE_API_URL']}/data/price?fsym=BTC&tsyms=USD" }
    let(:headers) { { "Content-Type" => "application/json" } }
    subject(:coin_price) { described_class.instance.coin_price }

    it "should call the cryptocompare API" do
      expect(HTTParty).to receive(:get).with(url, headers: headers)
      coin_price
    end
  end
end
