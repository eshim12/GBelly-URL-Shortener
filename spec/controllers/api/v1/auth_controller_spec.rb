require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
	it "has a status code of 202 when POST create" do
			post :create, params: {username: 'gbelly', password: '12345'}
			expect(response.status).to eq(202)
	end
	it "has a status code of 401 when POST create with wrong password" do
			post :create, params: {username: 'gbelly', password: '14345'}
			expect(response.status).to eq(401)
	end
end
