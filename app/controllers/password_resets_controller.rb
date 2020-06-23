class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: %i(edit update)
  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "reset_password.password_reset_instructions"
      redirect_to root_url
    else
      flash.now[:danger] = t "reset_password.email_not_found"
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      flash[:danger] = t "reset_password.not_empty"
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t "reset_password.has_been_reset"
      redirect_to @user
    else
      flash[:warning] = t "reset_password.reset_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "users.not_found"
    redirect_to root_path
  end

  def valid_user
    return if (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
    flash[:danger] = t "reset_password.valid_user_fail"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "reset_password.reset_has_expired"
    redirect_to new_password_reset_url
  end
end
