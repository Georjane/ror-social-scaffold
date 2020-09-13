require 'rails_helper'

RSpec.describe 'Registering a new user', type: :feature do
    before :each do
        User.create(email: 'stayintouchuserfriendhipuser@test.tst', 
                    password: 'stayintouchuserfriendhipuser', 
                    name: 'stayintouchuser')
        User.create(email: 'stayintouchuserfriendhipfriend@test.tst',
                    password: 'stayintouchuserfriendhipfriend',
                    name: 'stayintouchuser')
        visit '/users/sign_in'
        within("form") do
            fill_in 'Email', with: 'stayintouchuserfriendhipuser@test.tst'
            fill_in 'Password', with: 'stayintouchuserfriendhipuser'
        end
        click_button 'Log in'
    end
    
    it 'list all registered users' do
        visit users_path
        expect(page).to have_content('stayintouchuser')
        expect(page).to have_link('See Profile')
        expect(page).to have_link('Send friend request')
    end
    
    it 'requests friendship to other user' do
        visit users_path
        click_link 'Send friend request'
        expect(page).to have_link('Pending')
    end

end
