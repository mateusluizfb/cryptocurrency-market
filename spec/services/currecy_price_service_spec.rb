require "rails_helper"

RSpec.describe CurrecyPriceService do
  describe "initialization" do
    it "can instantiate the singleton service" do
      expect(CurrecyPriceService.instance).to be_a CurrecyPriceService
    end
  end
end
