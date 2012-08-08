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
    context 'with Facebook' do
      before do
        @user     = FactoryGirl.create :user_with_facebook
        @venue    = FactoryGirl.create :venue_with_facebook
        @checkin  = FactoryGirl.create :checkin, user: @user, venue: @venue
      end

      it 'makes a Facebook::Checkin' do
        @checkin.provider_checkins.first._type.should == 'Facebook::Checkin'
      end

      it "checks into Facebook" do
        @checkin.provider_checkins.first.response['error'].should_not be
      end
    end
  end
end
