class Venue
  include Mongoid::Document
  has_many :provider_venues
end
