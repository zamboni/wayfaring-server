# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
  end
  
  factory :foursquare_provider, class: Foursquare::Provider do
  end
end