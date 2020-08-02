# == Schema Information
#
# Table name: sellers
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Seller < ApplicationRecord

  has_many :invoices, dependent: :nullify

  validates :name, uniqueness: true

end
