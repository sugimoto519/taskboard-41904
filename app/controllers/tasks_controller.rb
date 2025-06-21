class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_completion]

  def index
    @tasks = current_user.tasks.where(completed: false).order(deadline: :asc)
    @title = "すべてのタスク"
  end

  def today 
    @tasks = current_user.tasks.where(completed: false, deadline: Time.zone.now.all_day).order(deadline: :asc)
    @title = "今日のタスク"
    render :index
  end

  def week
    @tasks = current_user.tasks.where(completed: false, deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_week).order(deadline: :asc)
    @title = "今週のタスク"
    render :index
  end

  def new
    @task = Task.new 
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: 'タスクを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new 
    @commens = @task.comments.includes(:user).order(created_at: :desc)
  end 

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: 'タスクを更新しました'
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy 
    redirect_to root_path, notice: 'タスクを削除しました'
  end

  def toggle_completion 
    @task.update(completed: !@task.completed)
    if @task.completed?
      flash[:notice] = "タスク「#{@task.task_name}」を完了しました！"
    else 
      flash[:notice] = "タスク「#{@task.task_name}」を未完了に戻しました！"
    end 
    redirect_back(fallback_location: root_path)
  end

  def completed
    @tasks = current_user.tasks.where(completed: true).order(updated_at: :desc)
    @title = "完了したタスク"
    render :index
  end 

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end 

  def task_params
    params.require(:task).permit(:task_name, :deadline, :priority_id, :status_id, :content).merge(user_id: current_user.id)
  end

end
