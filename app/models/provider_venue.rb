class ProviderVenue
  include Mongoid::Document
  embedded_in :venue
  
  field :provider_id
  field :name
  field :lat
  field :lng
  
  validates :provider_id, presence: true
  
  def checkin_class
    "#{self.class.provider_type.classify}::Checkin".constantize
  end
  
  def self.provider_type
    self.to_s.split("::").first
  end

  def self.process_venues venues_hash
    [].tap do |venues|
      venues_hash.each do |venue|
        venues << self.find_or_create(venue)
      end
    end
  end
end
