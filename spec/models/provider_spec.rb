require 'spec_helper'

describe Provider do
  use_vcr_cassette
  context 'creates a provider of type' do
    context 'Foursquare' do
      before do
        @user = User.find_or_create_from_provider Foursquare::Provider, mocked_token_for('foursquare')
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
    
    context 'Facebook' do
      before do
        @user = User.find_or_create_from_provider Foursquare::Provider, mocked_token_for('facebook')
      end
      
      it 'with class' do
        @user.providers.first.class.should == Facebook::Provider
      end
      
      it 'with uid' do
        @user.providers.first.uid.should == mocked_uid_for('facebook')
      end
      
      it 'with token' do
        @user.providers.first.token.should == mocked_token_for('facebook')
      end
    end

    context 'Google' do
      before do
        @user = User.find_or_create_from_provider Google::Provider, mocked_token_for('google')
      end
      
      it 'with class' do
        @user.providers.first.class.should == Google::Provider
      end
      
      it 'with uid' do
        @user.providers.first.uid.should == mocked_uid_for('google')
      end
      
      it 'with token' do
        @user.providers.first.token.should == mocked_token_for('google')
      end
    end
  
  end
  
  it 'converts a hash to url options' do
    @options      = {user_name: 'user', password: 'pass'}
    Provider.merge_options_for_url(@options).should == '?user_name=user&password=pass'
  end
end
