class Provider
  include HTTParty
  
  include Mongoid::Document
  
  belongs_to :user
  
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
end
