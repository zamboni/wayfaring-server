require 'spec_helper'

describe Facebook::Venue do
  context 'finds or create' do
    before do
      @venue_hash = {"name"=>"Brooklyn Bridge", "category"=>"Interest", "location"=>{"city"=>"New York", "state"=>"NY", "country"=>"United States", "zip"=>"10005", "latitude"=>40.707681252133, "longitude"=>-73.999729093941}, "id"=>"111871368829109"}
    end

    it 'finds' do
      @venue = FactoryGirl.create :venue_with_facebook
      @venue.provider_venues.first.update_attributes(provider_id: '111871368829109')
      @found_venue = Facebook::Venue.find_or_create @venue_hash
      
      @found_venue.should == @venue
    end
    context 'creates' do
      before do
        @found_venue = Facebook::Venue.find_or_create @venue_hash
      end
      
      it 'a venue' do
        @found_venue.should be
      end
      
      it 'a venue with a name' do
        @found_venue.name.should == 'Brooklyn Bridge'
      end
      
      it 'a Facebook venue' do
        @found_venue.provider_venues.first._type.should == 'Facebook::Venue'
      end
      
      it 'a Facebook venue with proper id' do
        @found_venue.provider_venues.first.provider_id.should == '111871368829109'  
      end
      
      it 'a Facebook venue with a name' do
        @found_venue.provider_venues.first.name.should == 'Brooklyn Bridge'  
      end
    end
    context 'fails' do
      it 'raises error' do
        @venue_hash.delete('id')
        
        lambda{
          Facebook::Venue.find_or_create(@venue_hash)
        }.should raise_error
      end
    end
  end
  
  it 'finds or creates from a hash of venues' do
    venues =[{"name"=>"Brooklyn Bridge", "category"=>"Interest", "location"=>{"city"=>"New York", "state"=>"NY", "country"=>"United States", "zip"=>"10005", "latitude"=>40.707681252133, "longitude"=>-73.999729093941}, "id"=>"111871368829109"}, {"name"=>"Brooklyn Heights Historic District", "category"=>"Local business", "location"=>{"city"=>"Brooklyn", "state"=>"NY", "country"=>"United States", "zip"=>"11201", "latitude"=>40.695277499228, "longitude"=>-73.994829579884} , "id"=>"111038568950133"}]
    @new_venues = Facebook::Venue.process_venues venues
    
    @new_venues.count.should == 2
    @new_venues.first.class.should == Venue
    @new_venues.first.provider_venues.first.class.should == Facebook::Venue
  end   
end
