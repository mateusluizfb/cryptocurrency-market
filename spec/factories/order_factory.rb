FactoryBot.define do
  factory :order do
    owner_email  {"test@email.com"}
    coin_name    {"BTC"}
    coin_amount  {0.0151}
    dollar_value {101.50}
  end
end
