require "rails_helper"

RSpec.describe CryptoCurrenciesController, type: :controller do
  describe "GET #prices" do
    subject(:get_prices) { get :prices }

    it "should return 200 OK" do
      get_prices
      expect(response).to have_http_status :ok
    end
  end
end
