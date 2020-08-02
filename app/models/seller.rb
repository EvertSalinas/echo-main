# == Schema Information
#
# Table name: sellers
#
#  id         :bigint           not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Seller < ApplicationRecord

  has_many :invoices, dependent: :nullify

  validates :nombre, uniqueness: true

end
