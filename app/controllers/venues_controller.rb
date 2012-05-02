class VenuesController < ApplicationController
  respond_to :json
  
  def index
    @user = User.find params[:user_id]
    
    @venues = [].tap do |venues|
      @user.providers.each do |provider|
        venues.append(provider.venue_class.process_venues(provider.get_venues(params[:lat], params[:lng])))
      end
    end
    debugger
    render json: @venues.flatten.compact.to_json
  end
end
