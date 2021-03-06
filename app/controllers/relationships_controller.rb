class RelationshipsController < ApplicationController
  before_action :logged_in
  before_action :load_user_by_user, only: :create
  before_action :load_user_by_relationship, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def load_user_by_user
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "users.not_found"
    redirect_to root_path
  end

  def load_user_by_relationship
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user

    flash[:danger] = t "users.not_found"
    redirect_to root_path
  end
end
