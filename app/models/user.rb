require 'digest/sha2'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include OmniAuth::Identity::Models::Mongoid

  field :email, type: String
  field :name, type: String
  field :password_digest, type: String
  field :token
  
  has_many :providers
  
  after_create :create_token
  
  def self.find_or_create_from_provider provider_type, provider_token
    @provider_class = Object::const_get(provider_type.classify)::const_get('Provider')
    @uid            = @provider_class.get_uid provider_token
    @provider       = @provider_class.find_or_create_by(uid: @uid)

    if @provider.user
      @provider.update_attribute :token, provider_token
      
      return @provider.user
    else
      @user = create
      @provider.update_attributes(token: provider_token, user: @user)
      
      return @user
    end
  end
  
  def reset_password
    self.create_token
    UserMailer.reset_password(self).deliver
  end
  
  # def create_token
  #   self.update_attribute token, User.generate_token
  # end
  # 
  # def self.generate_token
  #   Digest::SHA256.hexdigest(Time.now.to_s + self.id.to_s)
  # end
  
  def create_provider provider_type, provider_token
    Object::const_get(provider_type.classify)::const_get('Provider').create! do |new_provider|
      new_provider.user  = self
      new_provider.token = provider_token
    end
  end
  
  def create_token
    token = Digest::MD5.hexdigest(Time.now.nsec.to_s + self.id.to_s)
    self.update_attribute :token, token
  end
end
