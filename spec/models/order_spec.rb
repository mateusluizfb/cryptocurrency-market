require "rails_helper"

RSpec.describe Order, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:owner_email) }
    it { is_expected.to validate_presence_of(:coin_name) }
    it { is_expected.to validate_presence_of(:coin_amount) }
    it { is_expected.to validate_presence_of(:dollar_value) }
  end
end
