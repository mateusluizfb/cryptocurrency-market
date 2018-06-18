require "rails_helper"

RSpec.describe CurrecyPriceService do
  describe "initialization" do
    it "can instantiate the singleton service" do
      expect(described_class.instance).to be_a CurrecyPriceService
    end
  end

  describe "#coin_price" do
    let(:headers) { {"Content-Type" => "application/json"} }
    let(:http_double) { instance_double(HTTParty::Response) }

    it "should call the cryptocompare API" do
      url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/pricemulti?fsyms=BTC&tsyms=USD"
      expect(HTTParty).to receive(:get).with(url, headers: headers).and_return(http_double)
      allow(http_double).to receive(:parsed_response).and_return([])
      described_class.instance.coin_price(currencies: ["BTC"])
    end

    it "should call the cryptocompare API with the coins received in the argument" do
      url = "#{ENV['CRYPTO_COMPARE_API_URL']}/data/pricemulti?fsyms=BTC,ETH,BCH&tsyms=USD"
      expect(HTTParty).to receive(:get).with(url, headers: headers).and_return(http_double)
      allow(http_double).to receive(:parsed_response).and_return([])
      described_class.instance.coin_price(currencies: ["BTC", "ETH", "BCH"])
    end

    it "should return coins prices" do
      VCR.use_cassette "crypto_compare/coin_prices" do
        prices = described_class.instance.coin_price(currencies: ["BTC", "ETH", "BCH"])
        expect(prices).to eq([
          {
            coin_name: "BTC",
            coin_price: 6723.89
          },
          {
            coin_name: "ETH",
            coin_price: 517.24
          },
          {
            coin_name: "BCH",
            coin_price: 888.3
          },
        ])
      end
    end
  end

  describe "#dolar_to_coin" do
    describe "should return the equivalent quantity of the dollars in coin" do
      it {
        amount = described_class.instance.currency_to_coin(coin_value: 6735.51, dollars: 6.74)
        expect(amount).to eq(0.001)
      }

      it {
        amount = described_class.instance.currency_to_coin(coin_value: 887.31, dollars: 44.37)
        expect(amount).to eq(0.05)
      }

      it {
        amount = described_class.instance.currency_to_coin(coin_value: 517.92, dollars: 517.92)
        expect(amount).to eq(1)
      }
    end
  end
end
