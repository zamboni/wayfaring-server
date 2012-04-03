class Foursquare::Provider < Provider
  base_uri 'https://api.foursquare.com/v2/'
  
  def self.get_uid provider_token
    options = {oauth_token: provider_token}
    response = self.get('/users/self' + Provider.merge_options_for_url(options))
    
    response['response']['user']['id']    
  end
end
