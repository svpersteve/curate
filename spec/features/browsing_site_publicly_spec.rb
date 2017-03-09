require 'rails_helper'

feature 'as a public user' do
  scenario 'when I visit the site' do
    visit root_path
    then_i_should_see_the_home_page
  end
end

def then_i_should_see_the_home_page
  expect(page).to have_content('Home')
end
