require 'spec_helper'

describe Users::ProvidersController do
  context 'oauth' do
    context 'Google' do
      before do
        get :authorize, provider_type: 'google', refesh_token: mocked_refesh_token_for('google'), access_token: mocked_access_token_for('google'), expires_in: 3600
      end

    end      
  end
  context 'destroying' do
    context 'Foursquare' do
      before do
        @user = FactoryGirl.create :user_with_foursquare
      end
      it 'logs a user out by removing their access token' do
        delete :destroy, user_id: @user.id, provider: {type: 'foursquare'}, format: 'json'
        @user.reload
        @user.providers.first.token.should_not be
      end
    end
    
    context 'Facebook' do
      before do
        @user = FactoryGirl.create :user_with_facebook
      end
      it 'logs a user out by removing their access token' do
        delete :destroy, user_id: @user.id, provider: {type: 'facebook'}, format: 'json'
        @user.reload
        @user.providers.first.token.should_not be
      end
    end
  end
end
