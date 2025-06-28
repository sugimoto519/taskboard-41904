require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:team) { create(:team, user: user)}
  let(:task) { create(:task, user: user, team: team) }

  describe 'コメント投稿' do 
    context 'コメントの投稿ができるとき' do 
      it '必要な情報がすべてそろっていれば投稿できる' do
        comment = build(:comment, user: user, task: task) 
        expect(comment).to be_valid
      end
    end

    context 'コメントの投稿ができないとき' do 
      let(:comment) { build(:comment, user: user, task: task)}
      it 'contentが空では登録できない' do 
        comment.content = ''
        comment.valid?
        expect(comment.errors.full_messages).to include("Content can't be blank")
      end
      it 'userが紐づいていなければ登録できない' do 
        comment.user = nil
        comment.valid?
        expect(comment.errors.full_messages).to include("User must exist")
      end
      it 'taskが紐づいていなければ登録できない' do 
        comment.task = nil
        comment.valid?
        expect(comment.errors.full_messages).to include("Task must exist")
      end
    end 
  end
end
