class Room < ActiveRecord::Base
	has_many :memberships
	has_many :users, through: :memberships
	validates :name, presence: true, length: { in: 6..20 }
end
