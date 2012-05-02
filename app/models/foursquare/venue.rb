class Foursquare::Venue < ProviderVenue
  include Mongoid::Document
  
  def self.find_or_create venue_hash
    Venue.where('provider_venues._type' => self.to_s, 'provider_venues.provider_id' => venue_hash['id']).first || 
    Venue.create!(name: venue_hash['name'], provider_venues: [ Foursquare::Venue.new(provider_id: venue_hash['id'], name: venue_hash['name']) ])
  end
  
  def self.process_venues venues_hash
    [].tap do |venues|
      venues_hash.each do |venue|
        venues << Foursquare::Venue.find_or_create(venue)
      end
    end
  end
end
