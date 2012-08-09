class Provider
  include HTTParty
  
  include Mongoid::Document
  
  embedded_in :user
  
  field :token
  field :uid

  def self.merge_options_for_url(options)
    options.inject('') do |urlized, (key, value)|
      urlized += urlized.empty? ? "?#{key}=#{value}" : "&#{key}=#{value}"
    end
  end
  
  def self.find_or_create provider_type, provider_token
    @provider_class = Object::const_get(provider_type.classify)::const_get('Provider')
    @uid            = @provider_class.get_uid provider_token
    @provider       = @provider_class.find_or_create_by(uid: @uid)
    @provider.update_attribute(:token, provider_token)
    return @provider
  end
  
  def self.client_credentials
    @credentials ||= YAML.load_file(File.join(Rails.root, 'config', 'provider_keys.yml'))
    client_credentials = @credentials[Rails.env][provider_type.downcase]
  end
  
  def self.provider_type
    self.to_s.split("::").first
  end

  def venue_class
    "#{self.class.provider_type.classify}::Venue".constantize
  end
  
  def user_credentials
    {oauth_token: self.token}
  end 
end
