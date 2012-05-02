class Venue
  include Mongoid::Document
  embeds_many :provider_venues
  field :name
  
  validates :name, presence: true
end
