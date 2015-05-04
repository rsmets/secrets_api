class Secret < ActiveRecord::Base
	validates :title, :user_id, :description, presence: true
end
