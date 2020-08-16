class IngridientsController < ApplicationController
  before_action :find_ingridient, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :find_recipe, only: [:new, :create]
  before_action :find_recipe_from_ingridient, only: [:edit, :update, :destroy]

  def new
    @ingridient = @recipe.ingridients.build
  end

  def create
    @ingridient = @recipe.ingridients.build(ingridient_params)
    if @ingridient.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @ingridient.update(ingridient_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    if equal_with_current_user?(@recipe.user)
      @ingridient.destroy
      redirect_to @recipe
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

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def find_recipe_from_ingridient
    @recipe = @ingridient.recipe
  end


  def correct_user
    @recipe = @ingridient.recipe
    unless equal_with_current_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end
end
