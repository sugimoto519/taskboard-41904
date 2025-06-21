class CommentsController < ApplicationController
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

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to task_path(@comment.task), notice: 'コメントを削除しました！', status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(content)
  end 
end
