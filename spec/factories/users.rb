# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name                   'Test User'
    email                  'test@example.com'

    factory :user_with_foursquare do
      providers { [ FactoryGirl.build(:foursquare_provider)]}    	
    end
  end
end
