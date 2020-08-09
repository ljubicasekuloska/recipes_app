class RecipesController < ApplicationController
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
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    (NUM_FIELDS - @recipe.ingridients.count).times { @recipe.ingridients.build }
    (NUM_FIELDS - @recipe.instructions.count).times { @recipe.instructions.build }
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description,
      ingridients_attributes: [:id, :content, :_destroy],
      instructions_attributes: [:id, :direction, :_destroy])
  end
end
