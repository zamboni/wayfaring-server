class Checkin
  include Mongoid::Document
  belongs_to :venue
  belongs_to :user

  embeds_many :provider_checkins

  after_create :checkin_to_providers

  def checkin_to_providers
    venue.provider_venues.each do |provider_venue|
      self.provider_checkins << provider_venue.checkin_class.new
    end
  end
end
