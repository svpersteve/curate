FactoryGirl.define do
  factory :user do
    sequence :full_name do |n|
      "Jake #{n}"
    end

    sequence :email do |n|
      "jake.shears#{n}@scissorsisters.com"
    end

    password 'wtf123'
    bio 'I make cool songs'
    auth_provider_profile_image 'image.jpg'
  end

  factory :admin, parent: :user do
    roles { [FactoryGirl.create(:role, name: 'admin')] }
  end
end
