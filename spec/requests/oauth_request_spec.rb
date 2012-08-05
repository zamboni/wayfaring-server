require 'spec_helper'
require 'yaml'

describe 'oauth' do
  context 'Foursquare' do
    it 'gets a oauth code' do
      oauther = Oauthorizer::Token.new
      token = oauther.get_foursquare_token_hash
    end
  end
  context 'Google' do
    it 'gets a oauth code' do
      oauther = Oauthorizer::Token.new
      token = oauther.get_google_token_hash
    end
  end
  context 'yml file' do
    before do
      pending 'overwires stuff'
    end
    it 'makes a yml file' do
      @hash = {'google' => {'token' => 'abc', 'secret' => Time.now}} 
      new_file = File.new(File.join(Rails.root, 'config', 'oauthorizer_config.yml'), 'w')
      new_file.write @hash.to_yaml.gsub("---\n", '')
      new_file.close
    end
    it 'throws a error if the file doesent exist' do
      pending
      begin
        no_file = File.new('no_file.yml', 'r')
      rescue
      end
    end
    it 'makes a hash from a file' do
      credentials ||= YAML.load_file(File.join(Rails.root, 'config', 'oauthorizer_config.yml'))
      credentials.should be
    end
    it 'adds to a file' do
      config_file = File.join(Rails.root, 'config', 'oauthorizer_config.yml')
      credentials ||= YAML.load_file(config_file)

      new_file = File.open(config_file, 'w+')
      new_file.write(credentials.to_yaml.gsub("---\n", ''))
      new_file.close
    end
  end
  context 'mechanize' do
    it 'does stuff' do
      agent = Mechanize.new
      login_page = agent.get("https://accounts.google.com/o/oauth2/auth?"  +
        "scope=https://www.googleapis.com/auth/latitude.all.best+https://www.googleapis.com/auth/userinfo.profile+https://www.googleapis.com/auth/userinfo.email" + 
        "&redirect_uri=http://localhost:3030/callbacks/google.json" +
        "&response_type=code" + 
        "&client_id=26827780047.apps.googleusercontent.com" + 
        "&approval_prompt=force" + 
        "&access_type=offline")
      login_page.form.Email   = 'test@rebelhold.com'
      login_page.form.Passwd  = 'rht3sting'
      auth_page = agent.submit(login_page.form, login_page.form.buttons.first)
      agent.submit(auth_page.form, auth_page.form.buttons.first)
    end
  end
end