class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_completion]

  def index
    # ユーザーが作成したタスク、またはユーザーが参加しているチームに属するタスクを表示
    @tasks = Task.where(user: current_user)
                 .or(Task.where(team_id: current_user.participating_teams.pluck(:id)))
                 .includes(:user)
                 .order(deadline: :asc)
    @title = "すべてのタスク"
  end

  def today
    @tasks = Task.where(deadline: Time.zone.now.all_day)
                 .where(user: current_user)
                 .or(Task.where(team_id: current_user.participating_teams.pluck(:id)))
                 .includes(:user)
                 .order(deadline: :asc)
    @title = "今日のタスク"
    render :index
  end

  def week
    @tasks = Task.where(deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_week)
                 .where(user: current_user)
                 .or(Task.where(team_id: current_user.participating_teams.pluck(:id)))
                 .includes(:user)
                 .order(deadline: :asc)
    @title = "今週のタスク"
    render :index
  end

  def new
    @task = Task.new(team_id: params[:team_id])
    @teams = current_user.participating_teams 
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: 'タスクを作成しました'
    else
      @teams = current_user.participating_teams
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new 
    @comments = @task.comments.includes(:user).order(created_at: :desc)
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
    @tasks = Task.where(completed: true)
               .where(user: current_user)
               .or(Task.where(team_id: current_user.participating_teams.pluck(:id)))
               .includes(:user)
               .order(updated_at: :desc)
    @title = "完了したタスク"
    render :index
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end 

  def task_params
    params.require(:task).permit(:task_name, :deadline, :priority_id, :status_id, :content, :team_id).merge(user_id: current_user.id)
  end

end
