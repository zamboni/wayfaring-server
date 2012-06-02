class UsersController < ApplicationController
  respond_to :json

  def create
    user      = User.find_or_create_from_provider params[:provider][:type], params[:provider][:token]
    provider_class = Object::const_get(params[:provider][:type].classify)::const_get('Provider')
    provider  = user.providers.where('_type' => provider_class.to_s).first
    if user
      render json: {user_id: user.id, provider_id: provider.id} and return
    end
    render json: {error: 'Could not create user'}
  end

  def index
  end
end
