module UsersHelper
  def friendship_status(user_to_evaluate)
    return if current_user.is_a_friend?(user_to_evaluate) # when we are friends

    status_btn = ""
    if current_user.pending_friendrequests.include?(user_to_evaluate) # 2. i have sent friend request, but not yet approved => pending
      status_btn << link_to('Pending', '#')
    elsif current_user.friendrequests.include?(user_to_evaluate) #3. i have received a friend request but yet confirmed => comfirm btn, or reject btn
      status_btn << link_to('Confirm', confirm_friend_request_path(user_id:user_to_evaluate.id), method: :put)
      status_btn << link_to('Decline', reject_friend_request(user_id:user_to_evaluate.id), method: :delete)
    else
      status_btn << link_to('Send friend request', send_friend_request_path(user_id:user_to_evaluate.id), method: :post)
    end
    status_btn.html_safe
  end
end
