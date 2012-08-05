require 'httparty'
class TokenRedirect
  def initialize(app, options={})
    @app = app
    @options = options
  end

  def call(env)
    @request = Rack::Request.new(env)
    if @request.path == '/callbacks/google.json'

      credentials ||= YAML.load_file(File.join(Rails.root, 'config', 'provider_keys.yml'))['test']['google']
      options = {
        code: @request.params['code'], 
        grant_type: 'authorization_code', 
        redirect_uri: 'http://127.0.0.1:3030/callbacks/google.json',
        client_id: credentials['consumer_key'], 
        client_secret: credentials['consumer_secret']
      }
      token_response = HTTParty.post('https://accounts.google.com/o/oauth2/token', body: options).parsed_response

      [200, {"Content-Type"=> 'application/json'}, token_response.to_json]
    end
  end
end