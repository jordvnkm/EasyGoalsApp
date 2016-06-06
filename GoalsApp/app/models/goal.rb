class Goal < ActiveRecord::Base
  validates :title, :user_id, :private_goal, presence: true


  has_many :comments, as: :commentable
  belongs_to :user
end
