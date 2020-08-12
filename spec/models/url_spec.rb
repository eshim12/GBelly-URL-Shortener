require 'rails_helper'

RSpec.describe Url, type: :model do
	context "creating a url" do
		it "is valid with valid attributes" do
			user = User.all.first
			url = Url.new(long_url: 'https://guides.rubyonrails.org/getting_started.html', slug: 'AbCdEf', user_id: user.id)
  			expect(url).to be_valid
		end
		it "is not valid without a long_url" do
			user = User.all.first
			url = Url.new(long_url: nil, slug: 'AbCdEf', user_id: user.id)
  			expect(url).to_not be_valid
		end
		it "is not valid without a slug" do
			user = User.all.first
			url = Url.new(long_url: nil, slug: nil, user_id: user.id)
  			expect(url).to_not be_valid
		end
		it "is not valid with an existing slug" do
			user = User.all.first
			url = Url.new(long_url: nil, slug: 'AbCdEg', user_id: user.id)
  			expect(url).to_not be_valid
		end
	end
end