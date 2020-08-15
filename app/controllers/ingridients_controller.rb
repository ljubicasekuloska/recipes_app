class IngridientsController < ApplicationController
  before_action :find_ingridient, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingridient = @recipe.ingridients.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingridient = @recipe.ingridients.build(ingridient_params)
    if @ingridient.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    @recipe = @ingridient.recipe
  end

  def update
    @recipe = @ingridient.recipe
    if @ingridient.update(ingridient_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    recipe = @ingridient.recipe
    if equal_with_current_user?(recipe.user)
      @ingridient.destroy
      redirect_to recipe
    else
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end

  private

  def ingridient_params
    params.require(:ingridient).permit(:content)
  end

  def find_ingridient
    @ingridient = Ingridient.find(params[:id])
  end

  def correct_user
    @recipe = @ingridient.recipe
    unless equal_with_current_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end
end
