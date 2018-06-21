require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  describe "GET #new" do
    subject(:new_order) {
      VCR.use_cassette "crypto_compare/coin_prices" do
        get :new
      end
    }

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

    it "should return 301" do
      create_order
      expect(response).to have_http_status :redirect
    end

    it "should create an order" do
      create_order
      expect(Order.count).to eq 1
    end

    it "should calculate the coin ammount" do
      expect_any_instance_of(CurrecyPriceService).to receive(:dollar_to_coin)
      create_order
    end

    it "should be errors for inconsistent coin price" do
      VCR.use_cassette "crypto_compare/btc_coin_price" do
        order_params[:coin][:data] = "BTC:6740.25"
        post :create, params: order_params
        expect(flash[:error]).to eq "Coin current price is not updated or it's wrong"
      end
    end
  end

  describe "GET #index" do
    subject(:show_orders) { get :index, params: { email: "fulano@email.com" } }

    it "should respond 200 ok" do
      show_orders
      expect(response).to have_http_status :ok
    end

    it "should search orders by email" do
      relation = double(ActiveRecord::Relation)
      expect(Order).to receive(:by_email).with("fulano@email.com")
        .and_return(relation)
      allow(relation).to receive(:all)
      show_orders
    end

    it "should have an orders instance variable" do
      FactoryBot.create :order, owner_email: "fulano@email.com"
      show_orders
      expect(assigns(:orders)).to_not be_blank
    end
  end
end
