class UserSessionsController < ApplicationController
  after_action :set_current_user, only: [:create, :new]
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session_id = SecureRandom.uuid
      UserActiveSession.new(user_id: user.id, session_id: session_id, status: true, session_expiry: 30.minutes.from_now).save
      session[:user_session_id] = session_id
      redirect_to users_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    if UserActiveSession.where(session_id: session[:user_session_id], status: true).exists?
      UserActiveSession.find_by(session_id: session[:user_session_id]).update(status: false)
    end
    session[:user_session_id] = nil
    redirect_to users_path, notice: "Logged out"
  end
end
