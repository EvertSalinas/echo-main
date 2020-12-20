# == Schema Information
#
# Table name: payment_logs
#
#  id                 :bigint           not null, primary key
#  folio              :string           not null
#  status             :integer          default("abierto"), not null
#  total_amount_cents :integer          not null
#  voucher            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :bigint
#  invoice_id         :integer
#
# Indexes
#
#  index_payment_logs_on_client_id  (client_id)
#  index_payment_logs_on_status     (status)
#
class PaymentLog < ApplicationRecord

  attr_accessor :seller_id

  enum status: { abierto: 0, agotado: 1 }

  belongs_to :client
  has_many   :payments

  monetize :total_amount_cents

  validates :folio,      presence: true
  validates :voucher,    presence: true, uniqueness: true
  validates :invoice_id, presence: true, on: :create
  validates :seller_id,  presence: true, on: :create

  after_create_commit :distribute_payments
  after_commit :deplete, unless: :agotado?

  def distribute_payments
    PaymentLogs::PaymentDistributor.new(
      payment_log: self,
      invoice_id:  invoice_id,
      seller_id: seller_id
    ).call
  end

  def remaining_balance
    total_amount - Money.new(payments.sum(:amount_cents))
  end

  def depleted?
    remaining_balance.zero?
  end

  private

  def deplete
    agotado! if depleted?
  end

end
