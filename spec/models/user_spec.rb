require 'spec_helper'

describe User do
  use_vcr_cassette
  
  context 'with a user' do
    before do
      @user = FactoryGirl.create :user
    end
    context 'finds a user with provider' do    
      context 'Foursquare' do
        before do
          @provider = FactoryGirl.create :foursquare_provider, user: @user, uid: mocked_uid_for('foursquare')
        end
      
        it 'that exists' do
          @provider = Provider.find_or_create 'foursquare', mocked_token_for('foursquare')
      
          @provider.user.should == @user
        end
      end
    end
  
    context 'creates a provider for a user' do
      context 'Foursquare' do
        context 'exists' do
          before do
            @foursquare = FactoryGirl.create :foursquare_provider, uid: mocked_uid_for('foursquare'), user: @user
            @provider = Provider.find_or_create 'foursquare', mocked_token_for('foursquare')
          end
          it 'finds provider' do
            @provider.should == @foursquare
          end
          it 'updates token' do
            @provider.token.should == mocked_token_for('foursquare')
          end
        end
        it 'does not exist' do
          @user.find_or_create_provider 'foursquare', mocked_token_for('foursquare')        
          
          @user.providers.first.class.should == Foursquare::Provider
        end
      end
    end
  end
end
