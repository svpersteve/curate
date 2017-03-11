require 'rails_helper'
include Warden::Test::Helpers

feature 'editing profiles' do

  as_a_logged_in_user do

    scenario 'editing my own profile' do
      when_i_edit_my_profile
      then_i_should_see_my_changes
    end

    scenario "trying to edit someone else's profile" do
      when_there_are_users
      when_i_visit_an_artists_profile
      then_i_should_not_see_an_edit_profile_link
      when_i_try_to_edit_an_artists_profile
      then_i_should_be_redirected
    end

  end
end

private

def when_i_edit_my_profile
  visit root_path
  click_on 'My profile'
  click_on 'Edit profile'
  fill_in 'Full name', with: 'New name'
  click_on 'Save changes'
end

def then_i_should_see_my_changes
  expect(page).to have_content('New name')
end

def then_i_should_not_see_an_edit_profile_link
  expect(page).to_not have_content('Edit profile')
end

def when_i_try_to_edit_an_artists_profile
  visit edit_user_path(@lisa)
end

def then_i_should_be_redirected
  expect(current_path).to_not eq(edit_user_path(@lisa))
end
