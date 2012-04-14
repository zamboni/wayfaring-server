require 'spec_helper'

describe Users::ProvidersController do
  before do
    @user = FactoryGirl.create :user
  end
  context 'destroying' do
    context 'foursquare' do
      before do
        @foursquare = FactoryGirl.create :foursquare_provider, token: mocked_token_for('foursquare'), uid: mocked_token_for('foursquare'), user: @user
      end
      it 'logs a user out by removing their access token' do
        delete :destroy, user_id: @user.id, provider: {type: 'foursquare'}, format: 'json'
        @foursquare.reload
        
        @foursquare.token.should_not be
      end
    end
  end
end
