require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての情報が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが重複していると登録できない' do
      end

      it 'emailに@が含まれていないと登録できない'
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字未満では登録できない' do
    end

    it 'passwordが英字のみでは登録できない' do
    end

    it ' passwordが数字のみでは登録できない' do
    end

    it 'passwordとpassword_confirmationが一致していないと登録できない' do
    end

    it 'last_name が空だと登録できない' do
    end

    it 'first_name が空だと登録できない' do
    end

    it 'last_name が全角でないと登録できない' do
    end

    it 'first_name が全角でないと登録できない' do
    end

    it 'last_name_kana が空だと登録できない' do
    end

    it 'first_name_kana が空だと登録できない' do
    end

    it 'last_name_kana がカタカナでないと登録できない' do
    end

    it 'first_name_kana がカタカナでないと登録できない' do
    end

    it 'birthday が空だと登録できない' do
    end
  end
end
