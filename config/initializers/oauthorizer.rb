oauthorizer_keys = YAML.load_file(File.join(Rails.root, 'config', 'oauthorizer_config.yml'))

Rails.application.config.middleware.insert_before ActionDispatch::Static, Rack::Oauthorizer, oauthorizer_keys

