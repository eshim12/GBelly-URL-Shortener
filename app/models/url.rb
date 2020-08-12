class Url < ApplicationRecord
	belongs_to :user

	validates :long_url, presence: true
	validates :slug, presence: true
	validates_uniqueness_of :slug
end
