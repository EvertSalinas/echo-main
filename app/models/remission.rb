# == Schema Information
#
# Table name: remissions
#
#  id                     :bigint           not null, primary key
#  cantidad_total         :decimal(, )      not null
#  condicion              :string           not null
#  estatus                :integer          default("pendiente"), not null
#  fecha_factura          :datetime         not null
#  fecha_remision         :datetime         not null
#  folio_remision_factura :string           not null
#  folio_remision_fisica  :string           not null
#  lugar                  :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  client_id              :bigint
#  seller_id              :bigint
#
# Indexes
#
#  index_remissions_on_client_id  (client_id)
#  index_remissions_on_estatus    (estatus)
#  index_remissions_on_seller_id  (seller_id)
#
class Remission < ApplicationRecord

  CONDITIONS = %w(credito contado).freeze

  belongs_to :client
  belongs_to :seller

  enum estatus: { pendiente: 0, pagada: 1, cancelada: 2 }

  validates :cantidad_total, presence: true
  validates :condicion, presence: true, inclusion: { in: CONDITIONS }
  validates :fecha_factura, presence: true
  validates :folio_remision_factura, presence: true, uniqueness: true
  validates :folio_remision_fisica, presence: true, uniqueness: true
  validates :lugar, presence: true

end
