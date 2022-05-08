require "administrate/base_dashboard"

class PaymentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    description: Field::Text,
    currency: Field::String,
    customer_id: Field::String,
    payment_data: Field::Time,
    receipt_commision: Field::Number,
    uuid: Field::String,
    charge_id: Field::String,
    stripe_commission: Field::Number,
    receipt_url: Field::String,
    receive_id: Field::String,
    post_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    amount: Field::Number,
    commision_result: Field::Number,
    payment_date: Field::Time
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    id
    amount
    description
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    id
    description
    currency
    customer_id
    payment_data
    uuid
    charge_id
    stripe_commission
    receipt_commision
    commision_result
    receipt_url
    receive_id
    post_id
    created_at
    updated_at
    amount
    payment_date
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    description
    currency
    customer_id
    payment_data
    uuid
    charge_id
    stripe_commission
    commision_result
    receipt_url
    receive_id
    post_id
    amount
    payment_date
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

  # Overwrite this method to customize how payments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(payment)
  #   "Payment ##{payment.id}"
  # end
end
