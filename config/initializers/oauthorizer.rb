
Rails.application.config.middleware.insert_before ActionDispatch::Static, Rack::GoogleOauthorizer, 
{
  consumer_key:     '810357465890-341or0n17maa39187055fip00b7mhqa6.apps.googleusercontent.com',
  consumer_secret:  'h6nXbs26rIGUl8sNX_f-VWww'
}

