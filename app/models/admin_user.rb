# == Schema Information
#
# Table name: admin_users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string
#  prefix                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("contaduria"), not null
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admin_users_on_email                 (email) UNIQUE
#  index_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  ROLES = %w(master contaduria almacen ventas).freeze

  has_many :orders
  has_many :invoices, dependent: :nullify

  validates :role, inclusion: { in: ROLES }

  scope :vendedores, -> { where(role: "ventas") } 

  ROLES.each do |role|
    define_method("#{role}_role?") do
      self.role == role
    end
  end

  # TODO move to module
  def sold_amount
    Money.new(invoices.sum(:total_amount_cents))
  end

  def clients
    invoices.joins(:client).pluck(:name).uniq
  end
end
