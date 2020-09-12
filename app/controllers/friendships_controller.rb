class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], status: false)
    if @friendship.save!
      redirect_to users_path, notice: 'Your friend request has been successfully sent.'
    else
      redirect_to users_path, alert: 'Something went wrong when trying to send the friend request. Please try again.'
    end
  end

  def update
    @friend = current_user.friendrequests.find(params[:friend])
    if current_user.confirm_request(@friend)
      redirect_to users_path, notice: "You are now friend with #{@friend.name}"
    else
      redirect_to users_path, alert: 'Your friendship confirmation failed Please try again!'
    end
  end

  def destroy
    @friend = current_user.friendrequests.find(params[:friend])
    if current_user.reject_request(@friend)
      redirect_to users_path, notice: "You have rejected friendship with #{@friend.name} successfully!"
    else
      redirect_to users_path, alert: 'Your friendship rejection failed. Please try again!'
    end
  end
end
