class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.page(params[:page]).per(Settings.users.per_page)
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "email.notice"
      redirect_to root_url
    else
      flash[:danger] = t "users.signup_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.profile_updated"
      redirect_to @user
    else
      flash[:danger] = t "users.update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.user_deleted"
      redirect_to users_path
    else
      flash[:danger] = t "users.delete_failed"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

  def logged_in_user
    return if logged_in
    store_location
    flash[:danger] = t "users.please_log_in"
    redirect_to login_path
  end

  def correct_user
    return if current_user? @user
    redirect_to root_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.not_found"
    redirect_to root_path
  end
end
