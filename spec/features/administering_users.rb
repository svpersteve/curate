require 'rails_helper'
include Warden::Test::Helpers

feature 'editing users' do

  as_an_admin do

    scenario 'editing a user profile' do
      when_there_are_users
      when_i_visit_an_artists_profile
      when_i_edit_the_artists_profile
      then_i_should_see_my_changes
    end

  end
end

private

def then_i_should_see_my_changes
  expect(page).to have_content('New name')
end

def when_i_edit_the_artists_profile
  click_on 'Edit'
  fill_in 'Full name', with: 'New name'
  click_on 'Save changes'
end
