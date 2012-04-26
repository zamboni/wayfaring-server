class VenuesController < ApplicationController
  respond_to :json
  
  def index
    @user = User.find params[:user_id]
    @venues = []
    @user.providers.each do |provider|
      @venues = provider.venue_class.process_venues provider.get_venues(params[:lat], params[:lng])
    end
    render json: @venues.to_json
  end
end
