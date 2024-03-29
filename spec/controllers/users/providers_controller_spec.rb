require 'spec_helper'

describe Users::ProvidersController do
  # use_vcr_cassette
  context 'oauth' do
    context 'Google' do
      before do
        pending 'fix oatherizer'
        oauther = Oauthorizer::Token.new
        code = oauther.get_google_code['code']
        get :authorize, provider_type: 'google', code: code
      end

      it 'has stuff' do
        User.first.should be
        User.first.providers.first._type.should == 'Google::Provider'
        User.first.providers.first.token.should be
        User.first.providers.first.refresh_token.should be
        User.first.providers.first.expiration.should be
      end

      # it 'has a user' do
      #   User.first.should be
      # end

      # it 'has a google provider' do
      #   User.first.providers.first._type.should == 'Google::Provider'
      # end

      # it 'has a access token' do
      #   User.first.providers.first.token.should be
      # end

      # it 'has a refresh token' do
      #   User.first.providers.first.refresh_token.should be
      # end

      # it 'has a expiration date' do
      #   User.first.providers.first.expiration.should be
      # end

    end      
  end
  context 'destroying' do
    context 'Foursquare' do
      before do
        @user = FactoryGirl.create :user_with_foursquare
      end
      it 'logs a user out by removing their access token' do
        delete :destroy, user_id: @user.id, id: 'foursquare', provider: {type: 'foursquare'}, format: 'json'
        @user.reload
        @user.providers.first.token.should_not be
      end
    end
    
    context 'Facebook' do
      before do
        @user = FactoryGirl.create :user_with_facebook
      end
      it 'logs a user out by removing their access token' do
        delete :destroy, user_id: @user.id, id: 'foursquare', provider: {type: 'facebook'}, format: 'json'
        @user.reload
        @user.providers.first.token.should_not be
      end
    end
  end
end
