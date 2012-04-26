class Venue
  include Mongoid::Document
  embeds_many :provider_venues
end
