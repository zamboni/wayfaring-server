require 'spec_helper'

describe User do
  use_vcr_cassette
  context 'finds a user with a provider of type' do    
    context 'Foursquare' do
      before do
        @user = FactoryGirl.create :user_with_foursquare
      end
    
      it 'that exists' do
        @user = User.find_or_create_from_provider 'foursquare', mocked_token_for('foursquare')
    
        @user.should == @user
      end
    end
    context 'Facebook' do
      before do
        @user = FactoryGirl.create :user_with_facebook
      end
    
      it 'that exists' do
        @user = User.find_or_create_from_provider 'facebook', mocked_token_for('facebook')
    
        @user.should == @user
      end
    end
  end
  
  context 'creates a provider for a user' do
    context 'Foursquare' do
      before do
        @user = FactoryGirl.create :user

        @user.find_or_create_provider 'foursquare', mocked_token_for('foursquare')
      end

      it 'with class Foursquare::Provider' do
        @user.providers.first.class.should == Foursquare::Provider
      end

      it 'with uid' do
        @user.providers.first.uid.should == mocked_uid_for('foursquare')
      end

      it 'with token' do
        @user.providers.first.token.should == mocked_token_for('foursquare')
      end
    end
    context 'Facebook' do
      before do
        @user = FactoryGirl.create :user

        @user.find_or_create_provider 'facebook', mocked_token_for('facebook')
      end

      it 'with class Foursquare::Provider' do
        @user.providers.first.class.should == Facebook::Provider
      end

      it 'with uid' do
        @user.providers.first.uid.should == mocked_uid_for('facebook')
      end

      it 'with token' do
        @user.providers.first.token.should == mocked_token_for('facebook')
      end
    end
  end
end
