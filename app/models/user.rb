class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :name, type: String
  field :token
  
  has_many :providers, dependent: :destroy
  
  def find_or_create_provider provider_type, provider_token
    debugger
    @provider_class = Object::const_get(provider_type.classify)::const_get('Provider')
    @uid            = @provider_class.get_uid provider_token
    
    @provider       = @provider_class.find_or_create_by(uid: @uid)
    if @provider.user
      @provider.update_attribute :token, provider_token
    else
      @provider.update_attributes user: self, token: provider_token
    end
    @provider
  end
  
  def create_provider provider_type, provider_token
    Object::const_get(provider_type.classify)::const_get('Provider').create! do |new_provider|
      new_provider.user  = self
      new_provider.token = provider_token
    end
  end
end
