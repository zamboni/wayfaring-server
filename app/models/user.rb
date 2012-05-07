class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :name, type: String
  field :token
  
  has_many :checkins
  embeds_many :providers
  
  def find_or_create_provider provider_type, provider_token
    provider_class = Object::const_get(provider_type.classify)::const_get('Provider')
    uid            = provider_class.get_uid provider_token
    
    provider = self.providers.where('_type' => provider_class.to_s).first
    if provider
      provider.update_attribute :token, provider_token
    else
      provider = provider_class.new(token: provider_token, uid: uid)
      self.providers << provider
    end
    provider 
  end

  def self.find_or_create_from_provider provider_type, provider_token
    provider_class = Object::const_get(provider_type.classify)::const_get('Provider')
    uid            = provider_class.get_uid provider_token
    
    user = User.where('providers.uid' => uid, 'provider._type' => provider_class.to_s).first
    if user
      user.providers.where('_type' => provider_class.to_s).first.update_attribute :token, provider_token
    else
      user = User.create!(providers: [ provider_class.new(token: provider_token, uid: uid) ])
    end
    user 
  end
  
  def create_provider provider_type, provider_token
    Object::const_get(provider_type.classify)::const_get('Provider').create! do |new_provider|
      new_provider.user  = self
      new_provider.token = provider_token
    end
  end
end
