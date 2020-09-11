require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
  describe 'validation' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(200).with_message('200 characters in comment is the maximum allowed.')}
  end
  it 'when content has being validated, saving in the db succeeds' do
    user = User.create(name: 'Jane', email: 'jane@gmail.com', password: 'janejane')
    post = Post.create(content: 'this is our post content', user_id: user.id)
    comment = Comment.new(user_id: user.id, post_id: post.id, content: 'this is our comment content').save
    expect(comment).to be(true)
  end
end