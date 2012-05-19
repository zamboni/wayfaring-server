class Facebook::Provider < Provider
  base_uri 'https://graph.facebook.com/'

  def self.get_uid provider_token
    options = {access_token: provider_token}
    response = self.get('/me' + Provider.merge_options_for_url(options))
    
    response['id']    
  end

  def get_venues lat, lng
    options = {center: "#{lat},#{lng}", distance: '1000', type: 'place', access_token: token}
    response = self.class.get('/search' + Provider.merge_options_for_url(options))

    if response.response.code == '200'
      return response.parsed_response['data']
    end
  end
  
  def logout
    update_attribute :token, nil  
  end
end
