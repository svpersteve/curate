require 'rails_helper'

feature 'user sign-in' do

  scenario 'user can sign up' do
    visit new_user_registration_path
    create_an_account
    i_should_see_my_name
  end

  private

  def create_an_account
    fill_in 'user_full_name', with: 'Beyonce'
    fill_in 'user_username', with: 'beyonce'
    fill_in 'user_email', with: 'beyonce@star.com'
    fill_in 'user_password', with: 'wtf123'
    click_on 'Register'
  end

  def i_should_see_my_name
    expect(page).to have_content("Beyonce")
    expect(page).to have_content("@beyonce")
  end
end
