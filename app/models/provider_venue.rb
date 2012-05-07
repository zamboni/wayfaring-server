class ProviderVenue
  include Mongoid::Document
  embedded_in :venue
  
  field :provider_id
  field :name
  
  validates :provider_id, presence: true
  def checkin_class
    "#{self.class.provider_type.classify}::Checkin".constantize
  end
  
  def self.provider_type
    self.to_s.split("::").first
  end
end
