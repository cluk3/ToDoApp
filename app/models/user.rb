class User < ActiveRecord::Base
  has_many :created_tasks, :class_name => "Task", :foreign_key => "owner_id"
  has_many :assigned_tasks, :class_name => "Task", :foreign_key => "assignee_id"
end
