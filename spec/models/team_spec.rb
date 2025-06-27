require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'チーム登録' do
    # `let`を使って、テストの前提となるDB保存済みの有効なユーザーを作成
    let(:user) { create(:user) }

    context 'チームが登録できる場合' do
      it 'name, description, userが存在すれば作成できる' do
        # buildでチームを作成する際に、idを持つ有効な`user`を渡す
        team = build(:team, user: user)
        expect(team).to be_valid
      end
    end

    context 'チームが登録できない場合' do
      # 各テストの前に、有効なチームの雛形をbuildしておく
      let(:team) { build(:team, user: user) }

      it 'nameが空では登録できない' do
        team.name = ''
        team.valid?
        expect(team.errors.full_messages).to include("Name can't be blank")
      end

      it 'nameが256文字以上では登録できない' do
        team.name = 'a' * 256
        team.valid?
        expect(team.errors.full_messages).to include('Name is too long (maximum is 255 characters)')
      end

      it 'userが紐付いていないと登録できない' do
        team.user = nil
        team.valid?
        expect(team.errors.full_messages).to include('User must exist')
      end

      it '重複したnameが存在する場合は登録できない' do
        # 1つ目のチームをデータベースに保存する
        create(:team, user: user, name: 'Unique Team Name')

        # 2つ目のチームを同じ名前で作成しようとする
        another_team = build(:team, user: user, name: 'Unique Team Name')
        another_team.valid?
        expect(another_team.errors.full_messages).to include('Name has already been taken')
      end
    end
  end
end
