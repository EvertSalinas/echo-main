# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord

  has_many :invoices, dependent: :nullify
  # has_many :payments,   dependent: :nullify

  validates :name, uniqueness: true

end
