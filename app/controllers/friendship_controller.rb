class FriendshipController < ApplicationController
  def create
    @friendship = current_user.new(friend_id: params[:user_id], status: false)
    if @friendship.save?
      redirect_to users_path, notice: 'Your friend request has been successfully sent.'
    else
      redirect_to users_path, alert: 'Something went wrong when trying to send the friend request. Please try again.'
  end
  def update
    @user = User.find_by(params[:user_id])
    if current_user.confirm_request(@user)
      redirect_to users_path, notice: "You are now friend with #{@user.name}"
    else
      redirect_to users_path, alert: 'Your friendship confirmation failed Please try again!'
    end
  end

  def destroy
    @user = User.find_by(params[:user_id])
    if current_user.reject_request(@user)
      redirect_to users_path, notice: "You have rejected friendship with #{@user.name} successfully!"
    else
      redirect_to users_path, alert: 'Your friendship rejection failed. Please try again!'
    end
  end
end
