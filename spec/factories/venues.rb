# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name 'Venue Name'
    
    factory :venue_with_foursquare do
      provider_venues { [ FactoryGirl.build(:foursquare_venue) ] }
    end
  end
  
  factory :foursquare_venue, class: Foursquare::Venue do
    provider_id '1234'
  end
end