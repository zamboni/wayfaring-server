require 'spec_helper'

describe Provider do
  use_vcr_cassette
  context 'creates a provider of type' do
    context 'Foursquare' do
      before do
        @provider = Provider.find_or_create 'foursquare', mocked_token_for('foursquare')
        @provider.reload
      end
      
      it 'with class' do
        @provider.class.should == Foursquare::Provider
      end
      
      it 'with uid' do
        @provider.uid.should == mocked_uid_for('foursquare')
      end
      
      it 'with token' do
        @provider.token.should == mocked_token_for('foursquare')
      end
    end
  end
  
  it 'converts a hash to url options' do
    @options      = {user_name: 'user', password: 'pass'}
    Provider.merge_options_for_url(@options).should == '?user_name=user&password=pass'
  end
end