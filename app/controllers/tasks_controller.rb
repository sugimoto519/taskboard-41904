class TasksController < ApplicationController
  before_action :set_week, only: [:edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order("created_at ASC")
  end

  def today 
    @tasks = current_user.tasks.where(deadline: Time.zone.now.all_day).order(deadline: :asc)
    @title = "今日のタスク"
    render :index
  end

  def week
    @tasks = current_user.tasks.where(deadline: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).order(deadline: :asc)
    @title = "今週のタスク"
    render :index
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
  end

  def update
    @task.update(task_params)
    redirect_to root_path
  end

  def destroy
    @task.destroy 
    redirect_to root_path
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end 

  def task_params
    params.require(:task).permit(:task_name, :deadline, :priority_id, :status_id, :content).merge(user_id: current_user.id)
  end

end
