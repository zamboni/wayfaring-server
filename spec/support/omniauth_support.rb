PROVIDERS = {
  foursquare: {
    token: 'UJ4S0DJFXU00KFVFF1T4CX5FNFFD4JOSIVT52HGPM3YXC2OV', 
    uid: '20566366'
  },
  facebook:   {
    token: 'BAAErTBz7PZB0BAMLiGa1zq1CYA9sflZCkZA66L0TVdpH2p73xWK3VqvYrRIkzR23n6PmvI4cyqZBMvTMpYY0iARqOVowEz0tiZBcVRE0QoSrPG4wYAY9fj40dvIluyL4xng9DjJ3RqgZDZD',
    uid: '100002952898027'
  },
  google:     {
    token: 'change me', 
    uid: 'notreal'
  }
}
  
def mock_provider_oauths
  PROVIDERS.each do |(provider, credentials)|
    OmniAuth.config.add_mock(provider.to_sym, {
      "credentials" => {"token" => credentials[:token]},
      "provider"=> provider,
      'uid' => credentials[:uid]
    })
  end
end
  
def mocked_uid_for provider
  PROVIDERS[provider.to_sym][:uid]
end
  
def mocked_token_for provider
  PROVIDERS[provider.to_sym][:token]
end