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
        coin_name: "fulano@email.com",
        dollar_value: 55.10
      }
    }}

    subject(:create_order) { post :create, params: order_params }

    it "should return 201" do
      create_order
      expect(response).to have_http_status :created
    end
  end
end
