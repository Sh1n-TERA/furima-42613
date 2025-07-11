class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :token, message: "can't be blank"
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, message: "can't be blank"
    validates :address, message: "can't be blank"
    validates :phone_number, message: "can't be blank"
    validates :user_id
    validates :item_id
  end

  validates :phone_number, format: { with: /\A\d+\z/, message: 'is invalid. Input only number' },
                           length: { minimum: 10, maximum: 11, message: 'is too short' }

  def save
    # Orderテーブルに購入情報を保存
    order = Order.create(user_id: user_id, item_id: item_id)

    # Addressテーブルに配送先情報を保存
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
