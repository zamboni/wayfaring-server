class Venue
  include Mongoid::Document
  embeds_many :provider_venues
  has_many :checkins
  
  field :name
  
  validates :name, presence: true
  
  def self.find_or_create_from_providers providers, lat, lng
    @venues = [].tap do |venues|
      providers.each do |provider|
        provider_venue_class = provider.venue_class
        venues.append(provider_venue_class.process_venues(provider.get_venues(lat, lng)))
      end
    end
  end
end
