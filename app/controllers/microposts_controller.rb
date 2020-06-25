class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach micropost_params[:image]
    if @micropost.save
      flash[:success] = t "micropost.created"
      redirect_to root_url
    else
      flash[:danger] = t "micropost.created_fail"
      @feed_items = current_user.feed.page(params[:page]).per(Settings.users.per_page)
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost.destroy_success"
    else
      flash[:danger] = t "micropost.destroy_fail"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::MICROPOST_PARAMS
  end

  def logged_in_user
    return if logged_in
    store_location
    flash[:danger] = t "users.please_log_in"
    redirect_to login_path
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost
    flash[:danger] = t "users.not_found"
    redirect_to root_url
  end
end
