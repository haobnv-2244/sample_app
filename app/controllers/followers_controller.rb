class FollowersController < ApplicationController
  before_action :logged_in_user, :load_user

  def index
    @title = t "follow.followers"
    @users = @user.followers.page(params[:page]).per Settings.users.per_page
    render "users/show_follow"
  end
end
