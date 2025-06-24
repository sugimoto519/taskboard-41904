require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end 

  describe 'ユーザー新規登録' do 
    it 'name,email,password,password_confirmationが存在すれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nameが空では登録できない' do 
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include ("Name can't be blank")
    end
    it 'emailが空では登録できない' do 
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include ("Email can't be blank")
    end
    it 'passwordが空では登録できない' do 
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do 
      @user.password = '12345'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      binding.pry
    end
    it 'emailは@を含まないと登録できない' do 
    end
    it 'passwordが5文字以下では登録できない' do 
    end
    it 'passwordが129文字以上では登録できない' do 
    end
  end 
end
