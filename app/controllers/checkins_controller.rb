class CheckinsController < ApplicationController
  respond_to :json
  
  def create
    @checkin = Checkin.create params[:checkin]
    if @checkin.save
      render json: @checkin
    end
  end
end