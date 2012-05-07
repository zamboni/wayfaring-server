# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checkin do
    factory :checkin_with_foursquare do
      provider_checkins { [ FactoryGirl.build(:foursquare_checkin) ] }
    end
  end
  factory :foursquare_checkin, class: Foursquare::Checkin do
    
  end
end