module UsersHelper
  def friendship_status(user_to_evaluate)
    return if current_user.id == user_to_evaluate.id

    return if current_user.a_friend?(user_to_evaluate)

    status_btn = ''
    if current_user.pending_friendrequests.include?(user_to_evaluate)
      status_btn << link_to('Pending', '#')
    elsif current_user.friendrequests.include?(user_to_evaluate)
      status_btn << link_to('Confirm', confirm_friend_request_path(user_id: user_to_evaluate.id), method: :put)
      status_btn << link_to('Decline', reject_friend_request_path(user_id: user_to_evaluate.id), method: :delete)
    else
      status_btn << link_to('Send friend request',
                            send_friend_request_path(user_id: user_to_evaluate.id), method: :post)
    end
    status_btn.html_safe
  end
end
