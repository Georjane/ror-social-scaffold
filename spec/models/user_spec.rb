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
  describe 'validation' do
    it 'when name is empty, saving in the db fails' do
      user = User.new(email: 'usertest@test.tst', password: 'password').save
      expect(user).to be(false)
    end
    it 'when name has length greater than 20, saving in the db fails' do
      user = User.new(email: 'usertest@test.tst', password: 'password', name: 'userpasswordtotestistooloong').save
      expect(user).to be(false)
    end
    it 'when name has length less than 20, saving in the db succeed' do
      user = User.new(email: 'usertest@test.tst', password: 'password', name: 'userpasswordtotest').save
      expect(user).to be(true)
    end
  end
  describe 'testing helpers' do
    let(:user) { User.create(email: 'usertesthelpers@test.tst', password: 'password', name: 'userpasswordtotest') }
    let(:friend) do
      User.create(email: 'friendtesthelpers@test.tst',
                  password: 'password',
                  name: 'friendpasswordtotest')
    end
    it 'confirms the friend request' do
      user.friendships.new(friend_id: friend.id, status: false).save
      friend.confirm_request(user)
      expect(friend.a_friend?(user)).to be(true)
    end

    it 'rejecting friendhip request' do
      user.friendships.new(friend_id: friend.id, status: false).save
      friend.reject_request(user)
      expect(friend.inverse_friendships.include?(user)).to be false
    end
  end
end
