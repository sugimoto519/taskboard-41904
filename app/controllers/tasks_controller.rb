class TasksController < ApplicationController
  def index
    @tasks = Task.order("created_at DESC")
  end

  def new
    @task = Task.new 
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :deadline, :priority_id, :status_id, :content).merge(user_id: current_user.id)
  end

end
