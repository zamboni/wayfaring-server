require 'spec_helper'

describe Foursquare::Venue do
  it 'can be added to a venues provider_venues' do
    @venue = FactoryGirl.create :venue
    @foursquare_venue = FactoryGirl.create :foursquare_venue
    @venue.provider_venues << @foursquare_venue
    
    @venue.provider_venues.count.should == 1
  end
end
