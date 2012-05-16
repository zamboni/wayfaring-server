class Foursquare::Checkin < ProviderCheckin
  base_uri 'https://api.foursquare.com/v2/'

  after_create :checkin_to_provider 

  def checkin_to_provider
    provider = user_provider
    options = provider.user_credentials.merge({venueId: provider_venue.provider_id, broadcast: 'public'})
    response = self.class.post('/checkins/add' + Provider.merge_options_for_url(options))
    self.update_attribute :response, response
  end
end
