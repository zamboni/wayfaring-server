require 'spec_helper'

describe CheckinsController do
  context 'create' do
    context 'foursquare' do
     
      before do
        @user = FactoryGirl.create :user
        @venue = FactoryGirl.create :venue_with_foursquare
        put :create, checkin: {user_id: @user.id, venue_id: @venue.id}
      end
      it 'returns a checkin object'      
    end
  end
end
