class Api::V1::SecretsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :show, :index, :update, :destroy]
	respond_to :json

	def index
		respond_with current_user.secrets
	end

	def show
    	respond_with Secret.find(params[:id])
    end

    def create
	    secret = current_user.secrets.build(secret_params)
	    if secret.save
	      render json: secret, status: 201, location: [:api, secret]
	    else
	      render json: { errors: secret.errors }, status: 422
	    end
	end

	def update
	    secret = current_user.secrets.find(params[:id])
	    if secret.update(secret_params)
	      render json: secret, status: 200, location: [:api, secret]
	    else
	      render json: { errors: secret.errors }, status: 422
	    end
	end

	def destroy
    	secret = current_user.secrets.find(params[:id])
    	secret.destroy
    	head 204
  	end

  	private

    	def secret_params
    	  params.require(:secret).permit(:title, :description, :published)
   		end
end
