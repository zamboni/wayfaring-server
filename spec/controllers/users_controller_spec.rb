require 'spec_helper'

describe UsersController do
  use_vcr_cassette
  context 'creates a user' do
    context 'from a Provider' do
      context 'Foursquare' do
        before do
          get :create, provider: {type: 'foursquare', token: mocked_token_for('foursquare')}, format: 'json'
          @response = ActiveSupport::JSON.decode response.body
        end
        it 'returns a user_id' do
          @response['user_id'].should be
        end
      end
    end
  end
end
