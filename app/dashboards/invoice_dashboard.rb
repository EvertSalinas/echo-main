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
    condition: Field::Select.with_options(collection: Invoice::CONDITIONS),
    paid_out?: Field::Boolean,
    remaining_debt: Field::Number.with_options(prefix: "$", decimals: 2,),
    total_amount: Field::Number.with_options(prefix: "$", decimals: 2,),
    physical_folio: Field::String,
    system_folio: Field::String,
    system_date: Field::DateTime,
    physical_date: Field::DateTime,
    place: Field::String,
    status: Field::String,
    client: Field::BelongsTo.with_options(searchable: true, searchable_fields: ['name'],),
    seller: Field::BelongsTo.with_options(searchable: true, searchable_fields: ['name'],),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    payments: Field::HasMany,
    days_passed: Field::String.with_options(searchable: false)
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  system_folio
  physical_folio
  remaining_debt
  status
  days_passed
  client
  condition
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  condition
  paid_out?
  remaining_debt
  total_amount
  physical_folio
  system_folio
  system_date
  physical_date
  place
  days_passed
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
  condition
  physical_folio
  system_folio
  system_date
  total_amount
  physical_date
  place
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
    COLLECTION_FILTERS = {
      pendientes: ->(resources) { resources.where(status: 'pendiente') },
      pagadas: ->(resources) { resources.where(status: 'pagada') }
    }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how invoices are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(invoice)
    "Factura #{invoice.system_folio}"
  end
end
