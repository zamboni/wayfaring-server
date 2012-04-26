# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
  end
  
  factory :venue_with_foursquare, parent: :venue do
    provider_venues { [ FactoryGirl.build(:foursquare_venue) ] }
  end
  
  factory :foursquare_venue, class: Foursquare::Venue do
    provider_id '1234'
  end
end