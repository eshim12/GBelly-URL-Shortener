class Api::V1::UsersController < ApplicationController
	skip_before_action :authorized, only: [:create]

	def create
		user = User.new(user_params)

		if user.save
			token = encode_token(user_id: user.id)

			render json: {user: UserSerializer.new(user), jwt: token}, status: 200
		else
			render json: {error: "invalid parameters"}, status: 401
		end
	end

	private

	def user_params
		params.permit(:username, :password)
	end
end
