class InstructionsController < ApplicationController
  before_action :find_instruction, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :find_recipe, only: [:new, :create]
  before_action :find_recipe_from_instruction, only: [:edit, :update, :destroy]

  def new
    @instruction = @recipe.instructions.build
  end

  def create
    @instruction = @recipe.instructions.build(instruction_params)
    if @instruction.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @instruction.update(instruction_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    if equal_with_current_user?(@recipe.user)
      @instruction.destroy
      redirect_to @recipe
    else
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end

  private

  def instruction_params
    params.require(:instruction).permit(:direction)
  end

  def find_instruction
    @instruction = Instruction.find(params[:id])
  end

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def find_recipe_from_instruction
    @recipe = @instruction.recipe
  end

  def correct_user
    @recipe = @instruction.recipe
    unless equal_with_current_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end
end
