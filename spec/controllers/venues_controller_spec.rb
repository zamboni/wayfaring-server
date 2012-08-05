require 'spec_helper'

describe VenuesController do
  # use_vcr_cassette
  context 'gets venues' do
    before do
      @oauther = Oauthorizer::Token.new
    end
    context 'Foursquare' do
      before do
        @token_hash = @oauther.get_google_token_hash
        @user = FactoryGirl.create :user_with_foursquare
        @user.providers.first.update_attribute :token, @token_hash['access_token']
        get :index, lat: 40.7, lng: -74, user_id: @user.id, format: 'json'
      end
      
      it 'returns a list of venues' do
        JSON.parse(response.body).count.should == 30
      end
    end
    context 'Facebook' do
      before do
        @token_hash = @oauther.get_facebook_token_hash
        @user = FactoryGirl.create :user_with_facebook
        @user.providers.first.update_attribute :token, @token_hash['access_token']
        
        get :index, lat: 40.7, lng: -74, user_id: @user.id, format: 'json'
      end
      
      it 'returns a list of venues' do
        JSON.parse(response.body).count.should > 20
      end
    end
  end

end
