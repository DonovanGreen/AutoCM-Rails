class ApplicationController < ActionController::Base

  def current_user
    User.find_by(id: self.user_id)
  end

  def user_id
    decoded_token.first['id']
  end

  def authorize_user!
    if !current_user.present?
      render json: { error: 'No user id present' }
    end
  end

  def decoded_token
    if token
      begin
        JWT.decode(token, "planningCalendar")
      rescue JWT::DecodeError
        return [{}]
      end
    else
      [{}]
    end
  end

  def token
    request.headers['Authorization']
  end
end
