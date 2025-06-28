require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  let(:user) { create(:user) }
  let(:team) { create(:team, user: user) }

  describe 'チームへの参加' do
    context 'チームへ参加できるとき' do 
      it 'userとteamがあれば参加できる' do 
        team_user = build(:team_user, user: user, team: team)
        expect(team_user).to be_valid
      end 
      it 'デフォルトの役割(role)がmemberであること' do 
        team_user = create(:team_user, user: user, team: team)
        expect(team_user.role).to eq('member')
      end
    end

    context 'チームへ参加できないとき' do 
      it 'userがなければ参加できない' do
        team_user = build(:team_user, user: nil, team: team)
        team_user.valid?
        expect(team_user.errors.full_messages).to include("User must exist")
      end 
      it 'teamがなければ参加できない' do 
        team_user = build(:team_user, user: user, team: nil)
        team_user.valid?
        expect(team_user.errors.full_messages).to include("Team must exist")
      end 
      it '同じユーザーと同じチームに重複して参加できない' do 
        create(:team_user, user: user, team: team)
        duplicate_team_user = build(:team_user, user: user, team: team)
        duplicate_team_user.valid?
        expect(duplicate_team_user.errors.full_messages).to include("User は既にこのチームに参加しています")
      end
    end
  end
end
