class User < ApplicationRecord
  has_many :orders
  has_many :items

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birthday

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー]+\z/, message: '全カタカナを使用してください' } do
      validates :last_name_kana
      validates :first_name_kana
    end

    validates :password, format: {
      with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
      message: 'には英字と数字の両方を含めて設定してください'
    }
  end
end
