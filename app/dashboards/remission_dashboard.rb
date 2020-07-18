require "administrate/base_dashboard"

class RemissionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    condicion: Field::String,
    folio_remision_fisica: Field::String,
    folio_remision_factura: Field::String,
    fecha_factura: Field::DateTime,
    cantidad_total_cents: Field::Number,
    fecha_remision: Field::DateTime,
    lugar: Field::String,
    status: Field::String,
    client_id: Field::Number,
    seller_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  condicion
  folio_remision_fisica
  folio_remision_factura
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  condicion
  folio_remision_fisica
  folio_remision_factura
  fecha_factura
  cantidad_total_cents
  fecha_remision
  lugar
  status
  client_id
  seller_id
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  condicion
  folio_remision_fisica
  folio_remision_factura
  fecha_factura
  cantidad_total_cents
  fecha_remision
  lugar
  status
  client_id
  seller_id
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how remissions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(remission)
  #   "Remission ##{remission.id}"
  # end
end
