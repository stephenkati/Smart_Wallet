class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def show
    @category = Category.includes(items: :author).find(params[:id])
    @items = @category.items.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @user = current_user
    @category.user = current_user

    if @category.save
      flash[:notice] = 'Category created successfully'
    else
      flash[:alert] = 'Failed to create Category!'
    end
    redirect_to categories_path
  end

  def edit
    @category = Category.includes(:user).find_by(id: params[:id])
  end

  def update
    @category = Category.includes(:user).find_by(id: params[:id])

    if @category.update(category_params)
      flash[:notice] = 'Category updated successfully'
    else
      flash[:alert] = 'Failed to update Category!'
    end
    redirect_to category_path(@category)
  end

  def destroy
    @category = Category.find(params[:id])
    @user = current_user
    flash[:alert] = if @category.destroy
                      'Category deleted successfully'
                    else
                      'Failed to delete Category!'
                    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
