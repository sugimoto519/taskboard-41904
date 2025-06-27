require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }
  let(:team) { create(:team, user: user) }

  describe 'タスク新規登録' do 
    context 'タスクの新規登録ができるとき' do 
      it '必要な情報がすべてそろっていれば登録できる' do
        task = build(:task, user: user, team: team) 
        expect(task).to be_valid
      end
      it 'priority_idが2以上であれば登録できる' do
        task = build(:task, user: user, team: team) 
        task.priority_id = 2
        expect(task).to be_valid
      end
      it 'status_idが2以上であれば登録できる' do 
        task = build(:task, user: user, team: team) 
        task.status_id = 2
        expect(task).to be_valid
      end
    end

    context 'タスクの新規登録ができないとき' do 
      let(:task) { build(:task, user: user, team: team)}
      it 'task_nameが空では登録できない' do 
        task.task_name = ''
        task.valid?
        expect(task.errors.full_messages).to include("Task name can't be blank")
      end
      it 'deadlineが空では登録できない' do 
        task.deadline = nil
        task.valid?
        expect(task.errors.full_messages).to include("Deadline can't be blank")
      end
      it 'priority_idが1だと登録できない' do 
        task.priority_id = 1
        task.valid?
        expect(task.errors.full_messages).to include("Priority can't be blank")
      end
      it 'status_idが1だと登録できない' do 
        task.status_id = 1
        task.valid?
        expect(task.errors.full_messages).to include("Status can't be blank")
      end
      it 'contentが空では登録できない' do 
        task.content = ''
        task.valid?
        expect(task.errors.full_messages).to include("Content can't be blank")
      end
      it 'userが紐づいていなければ登録できない' do 
        task.user = nil
        task.valid?
        expect(task.errors.full_messages).to include("User must exist")
      end
      it 'teamが紐づいていなければ登録できない' do 
        task.team = nil
        task.valid?
        expect(task.errors.full_messages).to include("Team must exist")
      end
    end 
  end
end
