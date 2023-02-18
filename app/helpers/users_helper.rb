module UsersHelper
  def user_avater(user)
    if user.avater?
      return image_tag user.avater.url, class: "user-avater-icon"
    else
      return image_tag "blank-profile-picture-973460_640.png", class: "user-avater-icon"
   end
  end
end
