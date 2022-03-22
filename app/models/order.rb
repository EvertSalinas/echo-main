# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  folio      :string
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Order < ApplicationRecord
  enum status: { pendiente: 0, completada: 1, cancelada: 2 }

  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  accepts_nested_attributes_for :order_details, :allow_destroy => true

  validates :folio, presence: true
  validates :status, presence: true
end
