require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :controller do
	context "Logged in as an authorized user" do
		before { allow(controller).to receive(:authorized).and_return(true) }

		it "has a status code of 200 when GET index" do
			get :index
			expect(response.status).to eq(200)
		end

		it "has a status code of 200 when POST create" do
			user = User.all.first
			post :create, params: {long_url: 'https://guides.rubyonrails.org/getting_started.html', slug: 'AbCdEf', user_id: user.id}
			expect(response.status).to eq(200)
		end

		it "redirects to the long_url when GET show" do
			get :show, params: {slug: 'AbCdEg'}
			expect(subject).to redirect_to('https://guides.rubyonrails.org/getting_started.html')
		end

		it "has a status code of 200 when PATCH update" do
			user = User.all.first
			patch :update, params: {id: user.id, slug: "cHaNGE"}
			expect(response.status).to eq(200)
		end

		it "has a status code of 200 when DELETE destroy" do
			user = User.all.first
			delete :destroy, params: {id: user.id}
			expect(response.status).to eq(200)
		end

		it "returns a message saying the url is now expired when DELETE destroy" do
			expected_body = {message: "URL is now expired"}
			user = User.all.first
			delete :destroy, params: {id: user.id}
			expect(response.body).to eq expected_body.to_json
		end
	end

	context "Not logged in" do
		it "has a status of 401 when GET index" do
			get :index
			expect(response.status).to eq(401)
		end

		it "returns a message to log in when GET index" do
			expected_body = {message: 'Please log in'}
			get :index
			expect(response.body).to eq expected_body.to_json
		end

		it "has a status code of 401 when POST create" do
			user = User.all.first
			post :create, params: {long_url: 'https://guides.rubyonrails.org/getting_started.html', slug: 'AbCdEf', user_id: user.id}
			expect(response.status).to eq(401)
		end

		it "redirects to the long_url when GET show" do
			get :show, params: {slug: 'AbCdEg'}
			expect(subject).to redirect_to('https://guides.rubyonrails.org/getting_started.html')
		end

		it "has a status code of 401 when PATCH update" do
			user = User.all.first
			patch :update, params: {id: user.id, slug: "cHaNGE"}
			expect(response.status).to eq(401)
		end
	end
end
