class Price < ApplicationRecord
  monetize :amount_cents, allow_nil: true

  belongs_to :product

  validates :amount_cents, numericality: { greater_than: 0, allow_nil: true }
end
