require 'rails_helper'

RSpec.describe User, type: :model do
	context "creating a user" do
		it "is valid with valid attributes" do
			user = User.new(username: 'ellibelli', password: "12345")
  			expect(user).to be_valid
		end
		it "is not valid without a username" do
			user = User.new(username: nil, password: "12345")
  			expect(user).to_not be_valid
		end
		it "is not valid without a password" do
			user = User.new(username: 'ellibelli', password: nil)
  			expect(user).to_not be_valid
		end
		it "is not valid with an existing username" do
			user = User.new(username: 'gbelly', password: "12345")
  			expect(user).to_not be_valid
		end
	end
end