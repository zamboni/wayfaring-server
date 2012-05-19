# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name 'Venue Name'
    
    factory :venue_with_foursquare do
      provider_venues { [ FactoryGirl.build(:foursquare_venue) ] }
    end

    factory :venue_with_facebook do
      provider_venues { [ FactoryGirl.build(:facebook_venue) ] }
    end
  end
  
  factory :foursquare_venue, class: Foursquare::Venue do
    provider_id '1234'
  end

  factory :facebook_venue, class: Facebook::Venue do
    provider_id '111871368829109'
    lat         40.69994125694707
    lng         73.99903456915965
  end
end