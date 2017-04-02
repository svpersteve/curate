require 'rails_helper'

feature 'User sign up' do
  let(:user) { FactoryGirl.create(:user, full_name: 'Steve Brewer', auth_provider_profile_image: '', provider: 'facebook', uid: '123545') }

  background do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: '123545',
      extra: { raw_info: { "full_name" => "Steve Brewer", "email" => "steve@gmail.com", "first_name" => "Steve", "last_name" => "Brewer", "auth_provider_profile_image" => 'pic.jpg' } }
    )
  end

  before do
    allow(user).to receive(:avatar_thumbnail).and_return('pic.jpg')
  end

  scenario 'with Facebook' do
    visit root_path
    click_on 'Sign in'
    click_on 'Sign in with Facebook'
    expect(page).to have_content(user[:auth_provider_profile_image])
  end
end
