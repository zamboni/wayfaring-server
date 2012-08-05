class Google::Provider < Provider
  base_uri 'https://www.googleapis.com/oauth2/v1'
  field :refresh_token

  def self.client_credentials
    client_credentials = super
  end

  def self.get_uid token_hash
    options = {'Authorization' => "Bearer #{token_hash['access_token']}"}
    response = self.get('https://www.googleapis.com/oauth2/v1/userinfo', headers: options)
    response.parsed_response['id']    
  end

  def self.get_token_hash code
    credentials = self.client_credentials
    options = {code: code, grant_type: 'authorization_code', client_id: client_credentials['consumer_key'], client_secret: client_credentials['consumer_secret'], redirect_uri: client_credentials['redirect_uri']}
    response = self.post('https://accounts.google.com/o/oauth2/token', body: options).parsed_response
    provider_hash response
  end

  def self.provider_hash token_response

    {
      token: token_response['access_token'],
      expiration: (Time.now + token_response['expires_in'].seconds)
    }.merge(
      (token_response['refresh_token'].nil? ? {} : {refresh_token: token_response['refresh_token']})
    )
  end

  # def self.update_refresh_token refresh_token
  #   credentials = self.client_credentials
  #   options = {refresh_token: refresh_token, grant_type: 'refresh_token'}.merge credentials
  #   response = self.post('https://accounts.google.com/o/oauth2/token', body: options)
  # end

 


end
