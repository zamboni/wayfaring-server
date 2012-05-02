require 'spec_helper'

describe Foursquare::Venue do
  context 'finds or creates' do
    before do
      @venue_hash = {"id"=>"4f0daebfe4b01660dcc0ecc2", "name"=>"Morgan stanley", "contact"=>{}, "location"=>{"address"=>"111 Wall St, Manhattan, NY 10043", "lat"=>40.69994125694707, "lng"=>-73.99903456915965, "distance"=>81, "postalCode"=>"10043", "city"=>"New York", "state"=>"NY", "country"=>"United States"}, "categories"=>[{"id"=>"4bf58dd8d48988d174941735", "name"=>"Coworking Space", "pluralName"=>"Coworking Spaces", "shortName"=>"Coworking Space", "icon"=>{"prefix"=>"https://foursquare.com/img/categories/building/default_", "sizes"=>[32, 44, 64, 88, 256], "name"=>".png"}, "primary"=>true}], "verified"=>false, "stats"=>{"checkinsCount"=>4, "usersCount"=>1, "tipCount"=>0}, "specials"=>{"count"=>0, "items"=>[]}, "hereNow"=>{"count"=>0}}
    end
    it 'finds' do
      @venue = FactoryGirl.create :venue_with_foursquare
      @venue.provider_venues.first.update_attributes(provider_id: '4f0daebfe4b01660dcc0ecc2')
      @found_venue = Foursquare::Venue.find_or_create @venue_hash
      
      @found_venue.should == @venue
    end
    context 'creates' do
      before do
        @found_venue = Foursquare::Venue.find_or_create @venue_hash
      end
      it 'a venue' do
        @found_venue.should be
      end
      
      it 'a venue with a name' do
        @found_venue.name.should == 'Morgan stanley'
      end
      
      it 'a foursquare venue' do
        @found_venue.provider_venues.first._type.should == 'Foursquare::Venue'
      end
      
      it 'a foursquare venue with proper id' do
        @found_venue.provider_venues.first.provider_id.should == '4f0daebfe4b01660dcc0ecc2'  
      end
      
      it 'a foursquare venue with a name' do
        @found_venue.provider_venues.first.name.should == 'Morgan stanley'  
      end
    end
    context 'fails' do
      it 'raises error' do
        @venue_hash.delete('id')
        
        lambda{
          Foursquare::Venue.find_or_create(@venue_hash)
        }.should raise_error
      end
    end
  end
  
  it 'finds or creates from a hash of venues' do
    venues = [{"id"=>"4f0daebfe4b01660dcc0ecc2", "name"=>"Morgan stanley", "contact"=>{}, "location"=>{"address"=>"111 Wall St, Manhattan, NY 10043", "lat"=>40.69994125694707, "lng"=>-73.99903456915965, "distance"=>81, "postalCode"=>"10043", "city"=>"New York", "state"=>"NY", "country"=>"United States"}, "categories"=>[{"id"=>"4bf58dd8d48988d174941735", "name"=>"Coworking Space", "pluralName"=>"Coworking Spaces", "shortName"=>"Coworking Space", "icon"=>{"prefix"=>"https://foursquare.com/img/categories/building/default_", "sizes"=>[32, 44, 64, 88, 256], "name"=>".png"}, "primary"=>true}], "verified"=>false, "stats"=>{"checkinsCount"=>4, "usersCount"=>1, "tipCount"=>0}, "specials"=>{"count"=>0, "items"=>[]}, "hereNow"=>{"count"=>0}}, {"id"=>"4ed3af19b634dd29955299e1", "name"=>"18th Floor Executive Wash Room", "contact"=>{}, "location"=>{"address"=>"88 Pine St, New York, NY 10005", "lat"=>40.700871258714166, "lng"=>-74.00007900359161, "distance"=>97, "postalCode"=>"10005", "city"=>"New York", "state"=>"New York", "country"=>"United States"}, "categories"=>[{"id"=>"4bf58dd8d48988d174941735", "name"=>"Coworking Space", "pluralName"=>"Coworking Spaces", "shortName"=>"Coworking Space", "icon"=>{"prefix"=>"https://foursquare.com/img/categories/building/default_", "sizes"=>[32, 44, 64, 88, 256], "name"=>".png"}, "primary"=>true}], "verified"=>false, "stats"=>{"checkinsCount"=>43, "usersCount"=>5, "tipCount"=>0}, "specials"=>{"count"=>0, "items"=>[]}, "hereNow"=>{"count"=>0}}]
    @new_venues = Foursquare::Venue.process_venues venues
    
    @new_venues.count.should == 2
    @new_venues.first.class.should == Venue
    @new_venues.first.provider_venues.first.class.should == Foursquare::Venue
  end
end
