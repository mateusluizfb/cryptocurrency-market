require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #new" do
    subject(:new_order) { get :new }

    it "should return 200 ok" do
      new_order
      expect(response).to have_http_status :ok
    end

    it "should have an order instance variable" do
      new_order
      expect(assigns(:order)).to_not be_blank
    end
  end

  describe "POST #create" do
    let(:order_params) {{
      order: {
        owner_email: "fulano@email.com",
        dollar_value: 50.1
      },
      coin: {
        data: "BTC:6735.25"
      }
    }}

    subject(:create_order) {
      VCR.use_cassette "crypto_compare/btc_coin_price" do
        post :create, params: order_params
      end
    }

    it "should return 201" do
      create_order
      expect(response).to have_http_status :created
    end

    it "should create an order" do
      create_order
      expect(Order.count).to eq 1
    end

    it "should calculate the coin ammount" do
      expect_any_instance_of(CurrecyPriceService).to receive(:dollar_to_coin)
      create_order
    end
  end

  describe "GET #show" do

  end
end
