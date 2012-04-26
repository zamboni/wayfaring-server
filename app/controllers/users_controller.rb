class UsersController < ApplicationController
  before_filter :require_user, only: [:dashboard]
  respond_to :json
  
  def create
    @provider = Provider.find_or_create params[:provider][:type], params[:provider][:token]
    
    if @provider.user.nil?
      @user = User.create providers: [@provider]
      @user.save
    end
    render json: {user_id: @provider.user.id, provider_id: @provider.id}
  end
end
