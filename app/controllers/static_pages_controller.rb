class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: :report

  def home
    if logged_in?
      @task = current_user.created_tasks.build
      @created_tasks = current_user.created_tasks.paginate(page: params[:page])
      @assigned_tasks = current_user.assigned_tasks.paginate(page: params[:page])
      if params[:completed].present?
        @created_tasks = @created_tasks.where( completed: params[:completed]=="true")
        @assigned_tasks = @assigned_tasks.where( completed: params[:completed]=="true")
      end
    end
  end

  def report
    @tasks_num = current_user.created_tasks.count + current_user.assigned_tasks.count
    @completed_tasks_num = current_user.created_tasks.where(completed: true).count + current_user.assigned_tasks.where(completed: true).count
  end

end
