class InstructionsController < ApplicationController
  before_action :find_instruction, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build(instruction_params)
    if @instruction.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    @recipe = @instruction.recipe
  end

  def update
    @recipe = @instruction.recipe
    if @instruction.update(instruction_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    recipe = @instruction.recipe
    if equal_with_current_user?(recipe.user)
      @instruction.destroy
      redirect_to recipe
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

  def correct_user
    @recipe = @instruction.recipe
    unless equal_with_current_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end
end
