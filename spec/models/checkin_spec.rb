require 'spec_helper'

describe Checkin do
	context 'create' do
    context 'with Foursquare' do
      before do
        @user     = Factory.create :user_with_foursquare
        @venue    = Factory.create :venue_with_foursquare
        @checkin  = Factory.create :checkin, user: @user, venue: @venue
      end
      it 'makes a Foursquare::Checkin' do
        @checkin.provider_checkins.first._type.should == 'Foursquare::Checkin'
      end
    end
  end
end
