class Goal < ActiveRecord::Base
  validates :title, :user_id, :private_goal, presence: true

  belongs_to :user
end
