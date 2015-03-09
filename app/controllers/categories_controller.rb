class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
  end

  def destroy
      @category = Category.find(params[:id])
      @category.destroy
      respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create  
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'La categoria se creo correctamente' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category=  Category.find(params[:id])
     respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'La categoria se ha actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


private
  def category_params
      params.require(:category).permit(:name, :description)
    end
end