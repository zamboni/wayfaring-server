class Foursquare::Venue < ProviderVenue
  include Mongoid::Document
  field :provider_id
  
  validates :provider_id, presence: true
  
  def self.find_or_create venue_hash
    @venue = Venue.where('provider_venues._type' => self.to_s, 'provider_venues.provider_id' => venue_hash['id']).first
    unless @venue.present?
      @venue = Venue.create provider_venues: [ Foursquare::Venue.new(provider_id: venue_hash['id']) ]
      if @venue.save
        return @venue
      else
        return nil
      end
    end
    @venue
  end
  
  def self.process_venues venues_hash
    [].tap do |venues|
      venues_hash.each do |venue|
        venues << Foursquare::Venue.find_or_create(venue)
      end
    end
  end
  
end
