class CallbacksController < ApplicationController
  respond_to :json
  def google
    credentials ||= YAML.load_file(File.join(Rails.root, 'config', 'provider_keys.yml'))['test']['google']
    options = {
      code: params[:code], 
      grant_type: 'authorization_code', 
      redirect_uri: 'http://127.0.0.1:3030/callbacks/google.json',
      client_id: credentials['consumer_key'], 
      client_secret: credentials['consumer_secret']
    }
    token_response = HTTParty.post('https://accounts.google.com/o/oauth2/token', body: options).parsed_response
    render json: token_response.to_json
  end
end
