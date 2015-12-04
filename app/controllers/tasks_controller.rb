class TasksController < ApplicationController
  before_action :set_task, only: [:update]
  before_action :logged_in_user, only: [:create, :destroy, :update]
  before_action :correct_user, only: :destroy
  before_action :correct_user_update, only: :update


  # POST /tasks
  def create
    @task = current_user.created_tasks.build(task_params_create)
    @created_tasks = current_user.created_tasks.paginate(page: params[:page])

    category = /#\w*/.match(@task.value)
    @task.category = category[0][1..-1] unless category.nil?

    if assignee = /@\w* \w*/.match(@task.value)
      assignee = User.find_by name: assignee[0][1..-1]
      @task.assignee_id = assignee.id
    end

    # Overdue implementation to be done

    if @task.save
      flash[:success] = 'Task was successfully created.'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  #UPDATE /tasks/1
  def update
    if @task.update(completed: !@task.completed)
      flash[:success] = 'Task was successfully updated.'
      redirect_to request.referrer || root_url
    else
      render request.referrer || root_url
    end
  end


  # DELETE /tasks/1
  def destroy
    @task.destroy
    flash[:success] = 'Task was successfully deleted.'
    redirect_to request.referrer || root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params_create
      params.require(:task).permit(:value, :completed)
    end

    def task_params_update
      params.require(:task).permit(:completed)
    end

    def correct_user
      @task = current_user.created_tasks.find_by(id: params[:id])
      if @task.nil?
        flash[:warning] = 'You are not allowed to permorm this action.'
        redirect_to request.referrer || root_url
      end
    end

    def correct_user_update
      if (@task.owner_id != current_user.id) && (@task.assignee_id != current_user.id)
        flash[:warning] = 'You are not allowed to permorm this action.'
        redirect_to request.referrer || root_url
      end
    end
end
