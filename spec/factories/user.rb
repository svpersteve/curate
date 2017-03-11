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
  end
end
