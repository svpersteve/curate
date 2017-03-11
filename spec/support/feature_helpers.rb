module FeatureHelpers
  def when_there_are_users
    @lisa = FactoryGirl.create(:user, full_name: 'Lisa B', email: 'lisa@curate.com', slug: 'lisa-b')
    @viola = FactoryGirl.create(:user, full_name: 'Viola C', email: 'viola@curate.com', slug: 'viola-c')
  end

  def when_i_visit_an_artists_profile
    visit user_path(@lisa)
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
