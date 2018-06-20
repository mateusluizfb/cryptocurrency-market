class Order < ApplicationRecord
  validates :owner_email, presence: true
  validates :coin_name, presence: true
  validates :coin_amount, presence: true
  validates :dollar_value, presence: true

  scope :by_email, ->(email) { where(owner_email: email) }
end
