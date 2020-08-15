class RecipesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :find_recipe, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  NUM_FIELDS = 5
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    NUM_FIELDS.times { @recipe.ingridients.build }
    NUM_FIELDS.times { @recipe.instructions.build }
  end

  def show
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    (NUM_FIELDS - @recipe.ingridients.count).times { @recipe.ingridients.build }
    (NUM_FIELDS - @recipe.instructions.count).times { @recipe.instructions.build }
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end



  private

  def recipe_params
    params.require(:recipe).permit(:title, :description,
      ingridients_attributes: [:id, :content, :_destroy],
      instructions_attributes: [:id, :direction, :_destroy])
  end



  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def correct_user
    @recipe = Recipe.find(params[:id])
    unless equal_with_current_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end
end
