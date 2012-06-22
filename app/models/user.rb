class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :name, type: String
  field :token

  # TODO These should be moved to their classes
  field :refresh_token
  field :expiration,    type: DateTime

  has_many :checkins
  embeds_many :providers
  
  # def find_or_create_provider provider_type, provider_token
  #   provider_class = Object::const_get(provider_type.classify)::const_get('Provider')
  #   uid            = provider_class.get_uid provider_token

  #   provider = self.providers.where('_type' => provider_class.to_s).first
  #   if provider
  #     provider.update_attribute :token, provider_token
  #   else
  #     provider = provider_class.new(token: provider_token, uid: uid)
  #     self.providers << provider
  #   end
  #   provider 
  # end

  def self.find_or_create_from_provider provider_class, uid
    # provider_class = Object::const_get(provider_type.classify)::const_get('Provider')
    
    user = User.where('providers.uid' => uid, 'provider._type' => provider_class.to_s).first
    unless user
      user = User.create!(providers: [ provider_class.new(uid: uid) ])
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
