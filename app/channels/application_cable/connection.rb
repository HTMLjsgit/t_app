module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    #発言者のipを発言時取得するためにアクセサしておく
    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      session_key = cookies.encrypted[Rails.application.config.session_options[:key]]
      if session_key['warden.user.user.key'].present?
        verified_id = session_key['warden.user.user.key'][0][0]
        verified_user = User.find_by(id: verified_id)
        return reject_unauthorized_connection unless verified_user
        verified_user
      else
        return false
      end
    end
  end
end
