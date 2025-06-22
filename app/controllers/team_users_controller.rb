class TeamUsersController < ApplicationController
  before_action :set_team
  before_action :authorize_team_owner # チームオーナーのみがメンバーを管理できるようにする

  # メンバー追加
  def create
    user_to_add = User.find_by(email: params[:email])

    if user_to_add.nil?
      redirect_to @team, alert: '指定されたメールアドレスのユーザーは見つかりませんでした。'
      return
    end

    if @team.members.include?(user_to_add)
      redirect_to @team, alert: "#{user_to_add.name} はすでにこのチームのメンバーです。"
      return
    end

    @team_user = @team.team_users.build(user: user_to_add, role: :member)
    if @team_user.save
      redirect_to @team, notice: "#{user_to_add.name} をチームに追加しました。"
    else
      redirect_to @team, alert: 'メンバーの追加に失敗しました。'
    end
  end

  # メンバー削除
  def destroy
    @team_user = @team.team_users.find(params[:id])
    @team_user.destroy
    redirect_to @team, notice: "#{@team_user.user.name} をチームから削除しました。", status: :see_other
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def authorize_team_owner
    redirect_to teams_path, alert: 'チームメンバーを管理する権限がありません。' unless @team.user == current_user
  end
  
end
