require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should have_many(:likes) }
    it { should have_many(:comments) }
    it { should belong_to(:user) }
  end
  describe 'validation' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(1000).with_message('1000 characters in post is the maximum allowed.')}
  end
  it 'when content has being validated, saving in the db succeeds' do
    user = User.create(name: 'Jane', email: 'jane@gmail.com', password: 'janejane')
    post = Post.new(content: 'this is our post content', user_id: user.id).save
    expect(post).to be(true)
  end
end