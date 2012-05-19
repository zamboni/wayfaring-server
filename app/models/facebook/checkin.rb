class Facebook::Checkin < ProviderCheckin
  base_uri 'https://graph.facebook.com/'

  after_create :checkin_to_provider 

  def checkin_to_provider
    provider = user_provider
    options = provider.user_credentials.merge({place: provider_venue.provider_id})
    response = self.class.post('/me/checkins' + Provider.merge_options_for_url(options), query: { coordinates: { latitude: provider_venue.lat, longitude: provider_venue.lng }})
    self.update_attribute :response, response
  end
  # response = self.class.post('/me/checkins' + Provider.merge_options_for_url(options), query: { coordinates: { latitude: provider_venue.lat, longitude: provider_venue.lng }})
end
