require 'spec_helper'

describe User do
  use_vcr_cassette
  context 'creates a provider of type' do
    context 'Foursquare' do
      before do
        @user = User.find_or_create_from_provider 'foursquare', mocked_token_for('foursquare')
      end
      
      it 'with class' do
        @user.providers.first.class.should == Foursquare::Provider
      end
      
      it 'with uid' do
        @user.providers.first.uid.should == mocked_uid_for('foursquare')
      end
      
      it 'with token' do
        @user.providers.first.token.should == mocked_token_for('foursquare')
      end
    end
  end
  context 'finds a user with provider' do
    before do
      @user     = FactoryGirl.create :user
    end
    
    context 'Foursquare' do
      before do
        @provider = FactoryGirl.create :foursquare_provider, user: @user, uid: mocked_uid_for('foursquare')
      end
      
      it 'that exists' do
        @found_user = User.find_or_create_from_provider 'foursquare', mocked_token_for('foursquare')
      
        @found_user.should == @user
      end
    end
  end
end
