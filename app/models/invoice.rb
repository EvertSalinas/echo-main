# == Schema Information
#
# Table name: invoices
#
#  id                 :bigint           not null, primary key

#  physical_date      :date             not null
#  physical_folio     :string           not null
#  place              :string           not null
#  status             :integer          default("pendiente"), not null
#  system_date        :date             not null
#  system_folio       :string           not null
#  total_amount_cents :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  admin_user_id      :bigint
#  client_id          :bigint
#  seller_id          :bigint
#
# Indexes
#
#  index_invoices_on_admin_user_id  (admin_user_id)
#  index_invoices_on_client_id      (client_id)
#  index_invoices_on_seller_id      (seller_id)
#  index_invoices_on_status         (status)
#  index_invoices_on_system_folio   (system_folio)
#
class Invoice < ApplicationRecord
  attr_accessor :debt

  CONDITIONS = %w[credito contado].freeze

  belongs_to :client
  belongs_to :seller, optional: true
  belongs_to :admin_user, optional: true
  has_many   :payments

  enum status: { pendiente: 0, pagada: 1, cancelada: 2 }

  monetize :total_amount_cents

  validates :condition, presence: true, inclusion: { in: CONDITIONS }
  validates :physical_date, presence: true
  validates :system_date, presence: true
  validates :system_folio, presence: true, uniqueness: true
  validates :physical_folio, presence: true, uniqueness: true
  validates :place, presence: true

  after_commit :pay, unless: -> { :pagada? }

  def remaining_debt
    @debt = total_amount - Money.new(payments.sum(:amount_cents))
  end

  def credit
    total_amount - remaining_debt
  end

  def paid_out?
    remaining_debt.zero?
  end

  def days_passed
    return 0 if pagada?

    (Date.current - physical_date.to_date).to_i
  end

  def self.ransackable_scopes(_auth_object = nil)
    %i[
      days_passed_filter_equals
      days_passed_filter_greater_than
      days_passed_filter_less_than
    ]
  end

  def self.days_passed_filter_equals(value)
    where("DATE_PART('day', NOW() - physical_date) = #{value}")
  end

  def self.days_passed_filter_greater_than(value)
    where("DATE_PART('day', NOW() - physical_date) > #{value}")
  end

  def self.days_passed_filter_less_than(value)
    where("DATE_PART('day', NOW() - physical_date) < #{value}")
  end

  private

  def pay
    pagada! if paid_out?
  end
end
