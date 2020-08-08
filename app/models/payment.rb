# == Schema Information
#
# Table name: payments
#
#  id             :bigint           not null, primary key
#  amount         :decimal(, )      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  invoice_id     :bigint
#  payment_log_id :bigint
#
# Indexes
#
#  index_payments_on_invoice_id      (invoice_id)
#  index_payments_on_payment_log_id  (payment_log_id)
#
class Payment < ApplicationRecord

  belongs_to :payment_log
  belongs_to :invoice

  validates :amount, presence: true, numericality: { greater_than: 0 }

end
