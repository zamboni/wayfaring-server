class Facebook::Provider < Provider

  base_uri 'https://graph.facebook.com/'

  def self.get_uid provider_token
    options = {oauth_token: provider_token}
    response = self.get('/me' + Provider.merge_options_for_url(options))
    
    response['id']    
  end

end
