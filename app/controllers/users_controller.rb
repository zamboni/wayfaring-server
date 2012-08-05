class UsersController < ApplicationController
  respond_to :json

  def create
    provider_class  = Object::const_get(params[:provider][:type].classify)::const_get('Provider')
    user            = User.find_or_create_from_provider provider_class, params[:provider][:token]
    provider        = user.providers.where('_type' => provider_class.to_s).first
    if user
      render json: {user_id: user.id, provider_id: provider.id} and return
    end
    render json: {error: 'Could not create user'}
  end

  def index
  end
end
