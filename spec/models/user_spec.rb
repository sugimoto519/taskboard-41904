require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do 
    it 'nameが空では保存できない' do 
      user = User.new(name: '', email: 'test@test', password: '00000', password_confirmation: '00000')
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
    end
    it 'emailが空では保存できない' do 
      user = User.new(name: '山田', email: '', password: '00000', password_confirmation: '00000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
  end 
end
