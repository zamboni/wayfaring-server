require 'spec_helper'

describe Foursquare::Provider do
  it 'includes the date variable in client credentials' do
    credentials = Foursquare::Provider.client_credentials
    credentials[:v].should be
  end
end
