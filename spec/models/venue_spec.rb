require 'spec_helper'

describe Venue do
  use_vcr_cassette
  context 'creates venues' do
    context'from Foursquare' do
      before do
        @user = FactoryGirl.create :user_with_foursquare
        Venue.find_or_create_from_providers [@user.providers.first], 40.7, -74
      end
      
      it 'makes a venue' do
        Venue.first.should be
      end
    end

    context'from Facebook' do
      before do
        @user = FactoryGirl.create :user_with_facebook
        Venue.find_or_create_from_providers [@user.providers.first], 40.7, -74
      end
      
      it 'makes a venue' do
        Venue.first.should be
      end
    end
  end
end
