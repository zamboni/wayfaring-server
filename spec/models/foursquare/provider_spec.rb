require 'spec_helper'

describe Foursquare::Provider do
  it 'includes the date variable in client credentials' do
    @foursquare = FactoryGirl.create :foursquare_provider
    credentials = @foursquare.class.client_credentials
    credentials[:v].should be
  end
  
  it 'gets the Foursquare::Venue class' do
    @foursquare = FactoryGirl.create :foursquare_provider
    @foursquare.venue_class.should == Foursquare::Venue
  end
end
