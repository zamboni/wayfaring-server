require 'spec_helper'

describe Venue do
  use_vcr_cassette
  context 'creates venues' do
    context'from foursquare' do
      before do
        @provider = FactoryGirl.create :foursquare_provider
        Venue.find_or_create_from_providers [@provider], 40.7, -74
      end
      
      it 'makes a venue' do
        Venue.first.should be
      end
    end
  end
end
