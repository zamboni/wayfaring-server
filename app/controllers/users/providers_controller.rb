class Users::ProvidersController < ApplicationController
  respond_to :json
  
  def destroy
    @user = User.find params[:user_id]
    @provider_class = Object::const_get(params[:id].classify)::const_get('Provider')
    
    @provider = @user.providers.where(_type: @provider_class.to_s).first
    if @provider.update_attribute :token, nil
      render json: @provider.to_json
    else
      render text: 'Provider not found', status: 404
    end
  end
end
