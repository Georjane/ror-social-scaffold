require 'rails_helper'

RSpec.describe 'Authenticating a user', type: :feature do
    before :each do
        User.create(email: 'stayintouchuser@test.tst', password: 'stayintouchuser', name: 'stayintouchuser')
    end

    it 'Signs me in' do
        visit '/users/sign_in'
        within("form") do
          fill_in 'Email', with: 'stayintouchuser@test.tst'
          fill_in 'Password', with: 'stayintouchuser'
        end
        click_button 'Log in'
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Signed in successfully.')
    end

    it 'Refuse to sign me in when I provided wrong credentials' do
        visit '/users/sign_in'
        within("form") do
          fill_in 'Email', with: 'stayintouchus@test.tst'
          fill_in 'Password', with: 'stayintouchus'
        end
        click_button 'Log in'
        expect(current_path).to eq(user_session_path)
        expect(page).to have_content('Invalid Email or password.')
    end
end