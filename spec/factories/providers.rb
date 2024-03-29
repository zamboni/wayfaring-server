# Read about factories at http://github.com/thoughtbot/factory_girl
oauthorizer_keys = YAML.load_file(File.join(Rails.root, 'config', 'oauthorizer_config.yml'))

FactoryGirl.define do
  factory :provider do
  end
  
  factory :foursquare_provider, class: Foursquare::Provider do
    uid   oauthorizer_keys['foursquare']['uid']
    token oauthorizer_keys['foursquare']['access_token']
  end

  factory :facebook_provider, class: Facebook::Provider do
    token oauthorizer_keys['facebook']['access_token']
  end

end