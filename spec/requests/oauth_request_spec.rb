require 'spec_helper'

describe 'oauth' do
  context 'Google' do
    before do
      Capybara.server_port    = 3030
    end
    it 'gets a oauth code', js: true do
      oauther = Oautherizer::Token.new
      token = oauther.get_google_token

    end
  end
end