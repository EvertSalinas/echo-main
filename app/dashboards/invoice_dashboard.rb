require "administrate/base_dashboard"

class InvoiceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    condicion: Field::Select.with_options(collection: Invoice::CONDITIONS),
    paid_out?: Field::Boolean,
    remaining_debt: Field::Number.with_options(prefix: "$", decimals: 2,),
    cantidad_total: Field::Number.with_options(prefix: "$", decimals: 2,),
    folio_remision_fisica: Field::String,
    folio_remision_factura: Field::String,
    fecha_factura: Field::DateTime,
    fecha_remision: Field::DateTime,
    lugar: Field::String,
    estatus: Field::String,
    client: Field::BelongsTo.with_options(searchable: true, searchable_fields: ['nombre'],),
    seller: Field::BelongsTo.with_options(searchable: true, searchable_fields: ['nombre'],),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    payments: Field::HasMany
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  condicion
  paid_out?
  folio_remision_fisica
  folio_remision_factura
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  condicion
  paid_out?
  remaining_debt
  cantidad_total
  folio_remision_fisica
  folio_remision_factura
  fecha_factura
  fecha_remision
  lugar
  estatus
  client
  seller
  created_at
  updated_at
  payments
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  condicion
  folio_remision_fisica
  folio_remision_factura
  fecha_factura
  cantidad_total
  fecha_remision
  lugar
  estatus
  client
  seller
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

  # Overwrite this method to customize how invoices are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(invoice)
    "Invoice ##{invoice.id}"
  end
end
