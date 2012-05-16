require 'spec_helper'

describe Checkin do
  use_vcr_cassette
	context 'create' do
    context 'with Foursquare' do
      before do
        @user     = FactoryGirl.create :user_with_foursquare
        @venue    = FactoryGirl.create :venue_with_foursquare
        @checkin  = FactoryGirl.create :checkin, user: @user, venue: @venue
      end

      it 'makes a Foursquare::Checkin' do
        @checkin.provider_checkins.first._type.should == 'Foursquare::Checkin'
      end

      it "checks into Foursquare" do
        @checkin.provider_checkins.first.response['meta']['code'].should == 200
      end
    end
  end
end
