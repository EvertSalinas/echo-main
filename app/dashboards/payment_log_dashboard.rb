require "administrate/base_dashboard"

class PaymentLogDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    folio: Field::String,
    client: Field::BelongsTo,
    payments: Field::HasMany,
    invoice_id: Field::Select,
    id: Field::Number,
    status: Field::String,
    total_amount: Field::Number.with_options(searchable: false, prefix: "$", decimals: 2,),
    remaining_balance: Field::Number.with_options(searchable: false, prefix: "$", decimals: 2,),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  folio
  remaining_balance
  status
  client
  created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  folio
  client
  total_amount
  status
  remaining_balance
  created_at
  updated_at
  payments
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  folio
  client
  invoice_id
  total_amount
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

  # Overwrite this method to customize how payment logs are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(payment_log)
    "PaymentLog #{payment_log.folio}"
  end
end
