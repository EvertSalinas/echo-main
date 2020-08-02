# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord

  has_many :invoices, dependent: :nullify
  # has_many :payments,   dependent: :nullify

  validates :nombre, uniqueness: true

end
