require 'spec_helper'

describe Users::ProvidersController do
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
