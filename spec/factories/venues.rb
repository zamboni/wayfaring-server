# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
  end
  
  factory :foursquare_venue, class: Foursquare::Venue do
  end
end