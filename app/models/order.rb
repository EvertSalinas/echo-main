# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  folio         :string
#  status        :integer          default("pendiente"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  admin_user_id :bigint           not null
#  client_id     :bigint           not null
#  sequential_id :integer
#
# Indexes
#
#  index_orders_on_admin_user_id  (admin_user_id)
#  index_orders_on_client_id      (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_user_id => admin_users.id)
#  fk_rails_...  (client_id => clients.id)
#
class Order < ApplicationRecord
  enum status: { pendiente: 0, completada: 1, cancelada: 2 }

  acts_as_sequenced scope: :admin_user_id

  belongs_to :admin_user
  belongs_to :client

  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  accepts_nested_attributes_for :order_details, :allow_destroy => true

  # validates :folio, presence: true
  validates :status, presence: true

  after_create :add_prefix
  before_validation :move_status_back, on: :update

  private

  def add_prefix
    update_column(:folio, "#{admin_user.prefix}#{sequential_id}")
  end

  def move_status_back
    return if self.status_changed? && self.status_change[0] == 'pendiente'
    self.status = "pendiente" if status == "completada"
  end
end
