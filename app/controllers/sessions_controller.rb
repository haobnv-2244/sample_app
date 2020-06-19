class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user.try(:authenticate, params[:session][:password])
      flash[:success] = t "users.login_success"
      log_in user
      params[:session][:remember_me] == Settings.remember ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t "users.invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
