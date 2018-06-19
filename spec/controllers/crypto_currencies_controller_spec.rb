require "rails_helper"

RSpec.describe CryptoCurrenciesController, type: :controller do
  describe "GET #prices" do
    subject(:get_prices) {
      VCR.use_cassette "crypto_compare/main_coins_prices" do
        get :prices
      end
    }

    it "should return 200 OK" do
      get_prices
      expect(response).to have_http_status :ok
    end

    it "should invoke the currency price service" do
      expect_any_instance_of(CurrecyPriceService).to receive(:coin_price)
        .with(currencies: ["BTC", "ETH", "BCH", "LTC", "EOS"])
      get_prices
    end

    it "should have a currencies instance variable" do
      get_prices
      expect(assigns(:coins_prices)).to_not be_empty
    end
  end
end
