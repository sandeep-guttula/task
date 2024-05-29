class ApplicationController < ActionController::Base

  helper_method :current_user
  def current_user
    if session[:user_session_id]
      if UserActiveSession.where(session_id: session[:user_session_id], status: "active").exists?
        @current_user ||= User.find(UserActiveSession.find_by(session_id: session[:user_session_id]).user_id)
        Current.user = @current_user
      else
        session[:session_id] = nil
        @current_user = nil
      end
    end
  end

end
