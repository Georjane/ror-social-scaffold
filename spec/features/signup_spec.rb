require 'rails_helper'

RSpec.describe 'Registering a new user', type: :feature do
    it 'Register me on stayintouch app' do
        visit '/users/sign_up'
        within("form") do
          fill_in 'Email', with: 'stayintouchusertest2@test.tst'
          fill_in 'Password', with: 'stayintouchuser'
          fill_in 'Password confirmation', with: 'stayintouchuser'
          fill_in 'Name', with: 'stayintouchusertest2'
        end
        click_button 'Sign up'
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Welcome! You have signed up successfully.')
    end
    it 'Refuses register me on stayintouch app if I provided a wrong confirm password' do
        visit '/users/sign_up'
        within("form") do
          fill_in 'Email', with: 'stayintouchusertest2@test.tst'
          fill_in 'Password', with: 'stayintouchuser'
          fill_in 'Password confirmation', with: 'stayintouchuserwer'
          fill_in 'Name', with: 'stayintouchusertest2'
        end
        click_button 'Sign up'
        expect(current_path).to eq(users_path)
        expect(page).to have_content("Password confirmation doesn't match Passwor")
    end
end
