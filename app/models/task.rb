class Task < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  belongs_to :assignee, :class_name => "User"
  validates :owner, presence: true
  validates :value, presence: true
  default_scope -> { order(created_at: :desc) }

end
