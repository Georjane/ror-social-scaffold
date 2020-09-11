require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    include Devise::Test::ControllerHelpers

    describe 'get all posts when the user is not logged in' do
        subject{get :index}
        it { should redirect_to(new_user_session_path)}
    end

    describe 'when a user is logged in user' do
        it 'when a user logged in, accessing users path returns success' do
            user = User.create(name: 'userfortest', email: 'userfortest@test.tst', password: 'mypassword')
            sign_in user
            get :index
            assert_response :success
        end
    end
end