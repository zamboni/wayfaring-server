class ProviderVenue
  include Mongoid::Document
  embedded_in :venue
end
