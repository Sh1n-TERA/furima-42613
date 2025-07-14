require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入機能' do
    context '購入できるとき' do
      it 'すべての情報が正しく入力されていれば登録できる' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
        expect(order_address).to be_valid
      end

      it '建物名が空でも購入できる' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, building_name: '')
        expect(order_address).to be_valid
      end
    end

    context '購入できないとき' do
      it 'トークンが空では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, token: '')
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, postal_code: '')
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンがないと購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, postal_code: '1234567')
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県が未選択では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, prefecture_id: 1)
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, city: '')
        order_address.valid?
        expect(order_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, address: '')
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, phone_number: '')
        order_address.valid?
        expect(order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, phone_number: '090123456')
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end

      it '電話番号が12桁以上では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, phone_number: '090123456789')
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it '電話番号が全角数字では購入できない' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id, phone_number: '０９０１２３４５６７８')
        order_address.valid?
        expect(order_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
    end
  end
end
