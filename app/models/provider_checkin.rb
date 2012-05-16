class ProviderCheckin
  include Mongoid::Document

  include HTTParty
  field :response
  
  embedded_in :checkin

  def user_provider
    self.checkin.user.providers.where('_type' => (provider_type + '::Provider')).first
  end

  def provider_venue
    self.checkin.venue.provider_venues.where('_type' => (provider_type + '::Venue')).first
  end

  def provider_type
    self.class.to_s.split("::").first
  end
end
