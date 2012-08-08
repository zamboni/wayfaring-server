
def mocked_uid_for provider
  providers = get_providers_hash
  providers[provider][:uid]
end
  
def mocked_token_for provider
  providers = get_providers_hash
  providers[provider]['access_token']
end

def mocked_code_for provider
  providers = get_providers_hash
  providers[provider][:code]
end

def mocked_refresh_token_for provider
  providers = get_providers_hash
  providers[provider]['refresh_token']
end

def get_providers_hash
  YAML.load_file(File.join(Rails.root, 'config', 'oauthorizer_config.yml'))
end

