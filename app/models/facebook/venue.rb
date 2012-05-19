class Facebook::Venue < ProviderVenue
  def self.find_or_create venue_hash
    Venue.where('provider_venues._type' => self.to_s, 'provider_venues.provider_id' => venue_hash['id']).first || 
    Venue.create!(
      name: venue_hash['name'], 
      provider_venues: 
      [ 
        Facebook::Venue.new(
          provider_id: venue_hash['id'], 
          name: venue_hash['name'], 
          lat: venue_hash['location']['latitude'],
          lng: venue_hash['location']['longitude']
        )
      ]
    )
  end
end
