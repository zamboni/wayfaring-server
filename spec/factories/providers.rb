# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
  end
  
  factory :foursquare_provider, class: Foursquare::Provider do
    uid   '20566366'
    token 'UJ4S0DJFXU00KFVFF1T4CX5FNFFD4JOSIVT52HGPM3YXC2OV'
  end

  factory :facebook_provider, class: Facebook::Provider do
    token 'BAAErTBz7PZB0BAMLiGa1zq1CYA9sflZCkZA66L0TVdpH2p73xWK3VqvYrRIkzR23n6PmvI4cyqZBMvTMpYY0iARqOVowEz0tiZBcVRE0QoSrPG4wYAY9fj40dvIluyL4xng9DjJ3RqgZDZD'
  end

end