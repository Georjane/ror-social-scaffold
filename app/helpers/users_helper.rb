module UsersHelper
  def friendship_status(user_to_evaluate)
    return if current_user.is_a_friend?(user_to_evaluate)

    status_btn = ""
    if current_user.pending_friendrequests.include?(user_to_evaluate)
      status_btn << link_to('Pending', '#')
    elsif current_user.friendrequests.include?(user_to_evaluate)
      status_btn << (link_to('Confirm', '#'), link_to('Decline', '#'))
    end
  end
end
