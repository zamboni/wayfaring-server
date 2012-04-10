require 'spec_helper'

describe Users::ProvidersController do
  context 'logs out' do
    before do
      @user = FactoryGirl.create :user
    end
    context 'Foursquare' do
      before do
        @foursquare = FactoryGirl.create :foursquare_provider, user: @user, token: mocked_token_for('foursquare')
        delete :destroy, user_id: @user, id: 'foursquare', format: 'json'
      end
      
      it 'deletes the oauth token' do
        @foursquare.reload
        @foursquare.token.should == nil
      end
      
      it 'responds with 200' do
        response.code.should == "200"
      end
    end
  end
end
