# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name                   'Test User'
    email                  'test@example.com'
  end
end
