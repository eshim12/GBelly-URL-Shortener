require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
	context "POST create" do
		it "has a 200 status code with valid params" do
			post :create, params: {username: "ellibelli", password: '12345'}
			expect(response.status).to eq(200)
		end
		it "has a 401 status code without valid params" do
			post :create, params: {username: nil, password: '12345'}
			expect(response.status).to eq(401)
		end

		it "has returns invalid params message without valid params" do
			expected_body = {error: "invalid parameters"}
			post :create, params: {username: nil, password: '12345'}
			expect(response.body).to eq expected_body.to_json
		end
	end
end
