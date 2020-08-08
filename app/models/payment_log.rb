# == Schema Information
#
# Table name: payment_logs
#
#  id           :bigint           not null, primary key
#  total_amount :decimal(, )      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  client_id    :bigint
#
# Indexes
#
#  index_payment_logs_on_client_id  (client_id)
#
class PaymentLog < ApplicationRecord

  attr_accessor :invoice_id

  belongs_to :client
  has_many   :payments

  validates :total_amount, presence: true
  validates :invoice_id, presence: true

  after_create_commit :distribute_payments

  def distribute_payments
    PaymentLogs::PaymentDistributor.new(
      payment_log: self,
      invoice_id:  invoice_id
    ).call
  end

  def remaining_balance
    total_amount - payments.sum(:amount)
  end

  def depleted?
    remaining_balance.zero?
  end

end
