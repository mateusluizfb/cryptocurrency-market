class Order < ApplicationRecord
  validates :owner_email, presence: true
  validates :coin_name, presence: true
  validates :coin_amount, presence: true
end
