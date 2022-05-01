require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    follower: Field::HasMany,
    followed: Field::HasMany,
    following_user: Field::HasMany,
    follower_user: Field::HasMany,
    user_rooms: Field::HasMany,
    rooms: Field::HasMany,
    payments: Field::HasMany,
    posts: Field::HasMany,
    comments: Field::HasMany,
    real_comments: Field::HasMany,
    reals: Field::HasMany,
    likes: Field::HasMany,
    real_likes: Field::HasMany,
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::String,
    failed_attempts: Field::Number,
    unlock_token: Field::String,
    locked_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    username: Field::String,
    icon: Field::String,
    access_token: Field::String,
    bank_name: Field::String,
    bank_branch_name: Field::String,
    bank_account_type: Field::String,
    bank_account_number: Field::String,
    bank_account_horseman_name_kana: Field::String,
    ban: Field::Boolean,
    background_image: Field::Image,
    admin: Field::Boolean,
    avater: Field::Image,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    username
    email
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    email
    username
    icon
    access_token
    bank_name
    bank_branch_name
    bank_account_type
    bank_account_number
    bank_account_horseman_name_kana
    ban
    background_image
    admin
    avater
    user_rooms
    rooms
    payments
    posts
    comments
    real_comments
    reals
    likes
    real_likes

    follower
    followed
    following_user
    follower_user
    encrypted_password
    reset_password_token
    reset_password_sent_at
    remember_created_at
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
    confirmation_token
    confirmed_at
    confirmation_sent_at
    unconfirmed_email
    failed_attempts
    unlock_token
    locked_at
    created_at
    updated_at

  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    follower
    followed
    following_user
    follower_user
    user_rooms
    rooms
    payments
    posts
    comments
    real_comments
    reals
    likes
    real_likes
    email
    encrypted_password
    reset_password_token
    reset_password_sent_at
    remember_created_at
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
    confirmation_token
    confirmed_at
    confirmation_sent_at
    unconfirmed_email
    failed_attempts
    unlock_token
    locked_at
    username
    icon
    access_token
    bank_name
    bank_branch_name
    bank_account_type
    bank_account_number
    bank_account_horseman_name_kana
    ban
    background_image
    admin
    avater
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

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
