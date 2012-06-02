require "vcr"

VCR.config do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = 'rspec/vcr_cassettes'
  c.stub_with :fakeweb
  c.default_cassette_options = {:record => :new_episodes}
end