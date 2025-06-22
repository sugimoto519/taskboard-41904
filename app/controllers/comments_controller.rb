class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to task_path(@task), notice: 'コメントを投稿しました！'
    else
      @comments = @task.comments.includes(:user).order(created_at: :desc)
      render 'tasks/show', status: :unprocessable_entity
    end 
  end

  def edit
    @task = @comment.task
  end

  def update
    if @comment.update(comment_params)
      redirect_to task_path(@comment.task), notice: 'コメントを更新しました！'
    else
      @task = @comment.task
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    task = @comment.task
    @comment.destroy
    redirect_to task_path(task), notice: 'コメントを削除しました！', status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user
    redirect_to task_path(@comment.task), alert: '権限がありません！' unless @comment.user == current_user
  end

  def comment_params
    params.require(:comment).permit(:content)
  end 
end
