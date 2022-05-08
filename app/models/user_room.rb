class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def target_user_already_enter_to_room?(current_user, target_user)

  end
end
