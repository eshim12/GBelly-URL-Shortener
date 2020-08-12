require 'securerandom'

class Api::V1::UrlsController < ApplicationController
	skip_before_action :authorized, only: [:show]

	def index
		urls = Url.all.where(user_id: current_user)
		render json: urls, status: 200
	end

	def create
		url = Url.new(create_url_params)

		if url.save!
			render json: {url: UrlSerializer.new(url)}, status: 200
		else
			render status: 401
		end
	end

	def show
		url = Url.find_by(slug: params[:slug])

		if url
			redirect_to url[:long_url]
		else
			render json: {message: "This URL is expired!"}
		end

	end

	def update
		url = Url.find(params[:id])

		if url.update!(update_url_params) 
			render json: url, status: 200
		else
			render status: 401
		end
	end

	def destroy
		url = Url.find(params[:id])
		url.destroy!		

		render json: {message: "URL is now expired"}, status: 200
	end

	private

	def create_url_params
		params[:user_id] ||= current_user[:id]

		if params[:slug].nil?
			generate_slug
		end

		params[:shortened_url] = "#{request.base_url}/#{params[:slug]}"
		params.permit(:long_url, :slug, :user_id, :shortened_url)
	end

	def update_url_params
		params[:shortened_url] = "#{request.base_url}/#{params[:slug]}"
		params.permit(:slug, :shortened_url)
	end

	def generate_slug
		params[:slug] = SecureRandom.alphanumeric(6)
	end
end
