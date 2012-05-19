class Foursquare::Provider < Provider
  base_uri 'https://api.foursquare.com/v2/'
  
  def self.client_credentials
    client_credentials = super
    {client_id: client_credentials['consumer_key'], client_secret: client_credentials['consumer_secret'], v: client_credentials['api_date']}
  end

  def self.get_uid provider_token
    options = {oauth_token: provider_token}
    response = self.get('/users/self' + Provider.merge_options_for_url(options))
    
    response['response']['user']['id']    
  end
  
  def get_venues lat, lng
    @credentials = self.class.client_credentials
    options = {ll: "#{lat},#{lng}"}.merge @credentials
    response = self.class.get('/venues/search' + Provider.merge_options_for_url(options))
    if response.response.code == '200'
      return response.parsed_response['response']['venues']
    end
  end

  def logout
    update_attribute :token, nil
  end      
end
