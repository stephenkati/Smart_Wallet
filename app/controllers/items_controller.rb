class ItemsController < ApplicationController
  def new
    @category = Category.includes(:user).find_by(id: params[:category_id])
    @item = Item.new
  end

  def create
    @category = Category.includes(:user).find_by(id: params[:category_id])
    @item = Item.new(items_params)
    @item.author = current_user

    if @item.save
      @item.categories << Category.find(params[:category_id])
      flash[:notice] = 'Item created successfully'
    else
      flash[:alert] = 'Failed to create Item!'
    end
    redirect_to category_path(@category)
  end

  def edit
    @item = Item.find(params[:id])
    @category = @item.categories.first
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(items_params)
      flash[:notice] = 'Item updated successfully'
    else
      flash[:alert] = 'Failed to update Item!'
    end
    redirect_to category_path(@item.categories.first)
  end

  def destroy
    @item = Item.find(params[:id])
    @category = @item.categories.first

    flash[:alert] = if @item.destroy
                      'Item deleted successfully'
                    else
                      'Failed to delete Item!'
                    end
    redirect_to category_path(@category)
  end

  def items_params
    params.require(:item).permit(:name, :amount)
  end
end
