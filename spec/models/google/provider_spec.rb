require 'spec_helper'

describe Google::Provider do
  use_vcr_cassette
  context 'gets a token from a code' do
    before do
      @token = Google::Provider.get_token mocked_code_for('google')
    end

    it 'gets a access token' do
      @token.parsed_response['access_token'].should == 'ya29.AHES6ZQMGncI8x4V24-Tcz3R_uQnRdFAlAsMf9qr4PhOLno'
    end

    it 'gets a refresh token' do
      @token.parsed_response['refresh_token'].should == '1/ohoYDw8yVHiqtTzUPq0rqRcj705bIZKkl1iopCidVvs'
    end

    it 'expires' do
      @token.parsed_response['expires_in'].should == 3600
    end
  end
  context 'provider_hash' do
    before do
      @token_response = {provider_type: 'provider_type', access_token: 'access_token', expires_in: 3600}
    end

    it 'does not include refresh token' do
      token_hash = Google::Provider.provider_hash @token_response
      token_hash.should_not include(refresh_token)
    end
  end
end
