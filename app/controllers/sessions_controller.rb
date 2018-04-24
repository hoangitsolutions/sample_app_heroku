class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && password_authenticate?(user)
      action_vactivated? user
    else
      flash.now[:danger] = t "sessions.new.error_messages"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
