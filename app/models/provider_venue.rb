class ProviderVenue
  include Mongoid::Document
  embedded_in :venue
  
  field :provider_id
  field :name
  
  validates :provider_id, presence: true
end
