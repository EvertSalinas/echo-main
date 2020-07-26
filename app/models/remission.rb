# == Schema Information
#
# Table name: remissions
#
#  id                     :bigint           not null, primary key
#  cantidad_total_cents   :integer          not null
#  condicion              :string           not null
#  fecha_factura          :datetime         not null
#  fecha_remision         :datetime         not null
#  folio_remision_factura :string           not null
#  folio_remision_fisica  :string           not null
#  lugar                  :string           not null
#  status                 :string           default(NULL), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  client_id              :bigint
#  seller_id              :bigint
#
# Indexes
#
#  index_remissions_on_client_id  (client_id)
#  index_remissions_on_seller_id  (seller_id)
#
class Remission < ApplicationRecord

  belongs_to :client
  belongs_to :seller

  enum status: [:pendiente, :pagada]

  validates :cantidad_total_cents, presence: true
  validates :condicion, presence: true
  validates :fecha_factura, presence: true
  validates :folio_remision_factura, presence: true, uniqueness: true
  validates :folio_remision_fisica, presence: true, uniqueness: true
  validates :lugar, presence: true

end
