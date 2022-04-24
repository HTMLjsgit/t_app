class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :dm_count
  protected

  def dm_count
    if user_signed_in?
      @user_room_rels_count = 0
      user_room_rels = UserRoom.where(:user_id => current_user.id).or(UserRoom.where(:to_user_id => current_user.id))
      user_room_rels.find_each do | user_room_rel |
        @user_room_rels_count += ChatPost.where.not(:user_id => current_user.id).where(:see => 0).where(:room_id => user_room_rel.room_id).count
      end
    end
  end

  def configure_permitted_parameters
    added_attrs = [ :email, :username, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
