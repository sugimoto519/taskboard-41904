class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy] 
  before_action :authorize_owner, only: [:edit, :update, :destroy] 

  def index
    @teams = current_user.participating_teams.order(created_at: :desc)
  end

  def show
    unless @team.members.include?(current_user)
      redirect_to teams_path, alert: 'このチームにアクセスする権限がありません'
      return
    end
    @tasks = @team.tasks.includes(:user, :priority, :status).order(deadline: :asc)
  end

  def new
    @team = Team.new 
  end

  def create 
    @team = Team.new(team_params)
    @team.user = current_user

    if @team.save
      @team.team_users.create(user: current_user, role: :admin)
      redirect_to @team, notice: 'チームを作成しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'チームを更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @team.destroy
    redirect_to team_path, notice* 'チームを削除しました！', status: :see_other
  end

  private
  
  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description)
  end

  def authorize_owner
    redirect_to teams_path, alert: '権限がありません！' unless @team.user == current_user
  end
end
