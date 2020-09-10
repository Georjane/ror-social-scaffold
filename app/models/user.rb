class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: :user_id
  has_many :pending_friendrequests, through: :pending_friendships, source: :user

  has_many :received_friendrequests, -> { where status: false }, class_name: 'Friendship', foreign_key: :friend_id
  has_many :friendrequests, through: :received_friendrequests, source: :user

  def confirm_request(user)
    friend_to_confirm = Friendship.find_by(user_id: user.id, friend_id: id)
    friend_to_confirm.update(status: true)
  end

  def reject_request(user)
    friend_to_reject = friendrequests.find { |friendship| friendship.user == user }
    friend_to_reject.destroy
  end

  def is_a_friend?(user)
    friends.include?(user)
  end
end
