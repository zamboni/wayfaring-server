class VenuesController < ApplicationController
  respond_to :json
  
  def index
    @user   = User.find params[:user_id]
    @venues = Venue.find_or_create_from_providers @user.providers, params[:lat], params[:lng]
    render json: @venues.flatten.compact.to_json
  end
end
