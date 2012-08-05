class Users::ProvidersController < ApplicationController
  respond_to :json

  def authorize
    provider_class = "#{params[:provider_type].classify}::Provider".constantize
    token_hash      = provider_class.get_token_hash params[:code]
    uid             = provider_class.get_uid token_hash

    user = User.find_or_create_from_provider provider_class, uid 

    provider = user.providers.where('_type' => provider_class.to_s).first
    provider.update_attributes token_hash

    redirect_to "wayfaring://authorize#user_id=#{user.id}"
  end  

  def destroy
    @user = User.find params[:user_id]
    @provider_class = Object::const_get(params[:provider][:type].classify)::const_get('Provider')
    
    @provider = @user.providers.where(_type: @provider_class.to_s).first
    if @provider
      @provider.logout 
      render json: @provider.to_json
    else
      render text: 'Provider not found', status: 404
    end
  end
  
  def create
    @user = User.find params[:user_id]
    render json: @provider.to_json
  end
end