require 'rails_helper'

feature 'User sign up' do
  let(:user) { FactoryGirl.create(:user, full_name: 'Steve Brewer', auth_provider_profile_image: '', provider: 'instagram', uid: '123545') }

  background do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new(
      provider: 'instagram',
      uid: '123545',
      extra: { raw_info: { "full_name" => "Steve Brewer", "email" => "steve@gmail.com", "first_name" => "Steve", "last_name" => "Brewer", "auth_provider_profile_image" => 'pic.jpg', "username" => "svpersteve" } }
    )
  end

  scenario 'with Google OAuth2' do
    visit root_path
    click_on 'Sign in'
    click_on 'Sign in with Instagram'
    expect(page).to have_content(user[:full_name])
  end
end
