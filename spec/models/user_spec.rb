require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).with_foreign_key(:friend_id) }
    it { should have_many(:confirmed_friendships) }
    it { should have_many(:friends).through(:confirmed_friendships) }
    it { should have_many(:pending_friendships).with_foreign_key(:user_id) }
    it { should have_many(:pending_friendrequests).through(:pending_friendships) }
    it { should have_many(:received_friendrequests).with_foreign_key(:friend_id) }
    it { should have_many(:friendrequests).through(:received_friendrequests) }
  end
end
