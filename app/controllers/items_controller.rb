class ItemsController < ApplicationController
  def new
    @category = Category.includes(:user).find_by(id: params[:category_id])
    @item = Item.new
  end

  def create
    @category = Category.includes(:user).find_by(id: params[:category_id])
    @item = Item.new(items_params)
    @item.author = current_user

    flash[:notice] = if @item.save
                       @item.categories << Category.find(params[:category_id])
                       'Item created successfully'
                     else
                       'Failed to create Item!'
                     end
    redirect_to category_path(@category)
  end

  def destroy
    @item = Item.find(params[:id])
    @category = @item.categories.first

    flash[:notice] = if @item.destroy
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
