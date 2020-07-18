# == Schema Information
#
# Table name: sellers
#
#  id :bigint           not null, primary key
#
class Seller < ApplicationRecord

  has_many :remissions, dependent: :nullify

  validates :nombre, uniqueness: true

end
