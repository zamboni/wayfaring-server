require 'spec_helper'

describe VenuesController do
  use_vcr_cassette
  context 'gets venues' do
    context 'Foursquare' do
      before do
        @user = FactoryGirl.create :user
        @foursquare = FactoryGirl.create :foursquare_provider, user: @user, uid: (mocked_uid_for 'foursquare'), token: (mocked_token_for 'foursquare')
        
        get :index, lat: 40.7, lng: -74, user_id: @user.id, format: 'json'
      end
      
      it 'returns a list of venues' do
        JSON.parse(response.body).count.should == 30
      end
    end
  end

end
