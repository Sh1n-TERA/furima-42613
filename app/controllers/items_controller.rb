class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root_path, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      puts @item.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    # 画像が未選択の場合、画像以外で更新
    if item_params[:image].nil?
      if @item.update(item_params.except(:image))
        redirect_to item_path(@item)
      else
        render :edit, status: :unprocessable_entity
      end
    elsif @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :shipping_day_id, :price)
  end

  def move_to_root_path
    redirect_to root_path if current_user != @item.user
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
