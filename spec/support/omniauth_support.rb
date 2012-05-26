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
    token: 'ya29.AHES6ZQMGncI8x4V24-Tcz3R_uQnRdFAlAsMf9qr4PhOLno', 
    uid: '117314209189492854670',
    code: '4/P2mIOzikPZSYIGHe5a6_uvYJB7Ar.AtGHSsxydgYfuJJVnL49Cc-CSGTvbgI',
    refresh_token: '1/ohoYDw8yVHiqtTzUPq0rqRcj705bIZKkl1iopCidVvs'
  }
}
  
def mocked_uid_for provider
  PROVIDERS[provider.to_sym][:uid]
end
  
def mocked_token_for provider
  PROVIDERS[provider.to_sym][:token]
end

def mocked_code_for provider
  PROVIDERS[provider.to_sym][:code]
end

def mocked_refresh_token_for provider
  PROVIDERS[provider.to_sym][:refresh_token]
end

