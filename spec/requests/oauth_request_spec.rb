require 'spec_helper'

describe 'oauth' do
  context 'Google' do
    before do
      Capybara.current_driver = :selenium
      Capybara.server_port    = 3030
    end
    it 'gets a oauth code', js: true do
      visit "https://accounts.google.com/o/oauth2/auth?" +
        "scope=https://www.googleapis.com/auth/latitude.all.best+https://www.googleapis.com/auth/userinfo.profile+https://www.googleapis.com/auth/userinfo.email" + 
        "&redirect_uri=http://127.0.0.1:3030/callbacks/google.json" +
        "&response_type=code" + 
        "&client_id=810357465890-341or0n17maa39187055fip00b7mhqa6.apps.googleusercontent.com" + 
        "&approval_prompt=force" + 
        "&access_type=offline"
      fill_in 'Email', with: 'test@rebelhold.com'
      fill_in 'Passwd', with: 'rht3sting'
      click_button 'signIn'
      click_button 'submit_approve_access'
      token = JSON.parse(page.text)['access_token']
    end
  end
end