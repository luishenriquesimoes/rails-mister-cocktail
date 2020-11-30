class DosesController < ApplicationController
  before_action :set_cocktail, only: %i[new create edit update]
  before_action :set_dose, only: %i[edit update destroy]

  def new
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail), notice: 'Dose was successfully added'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @dose.update(dose_params)
      redirect_to cocktail_path(@cocktail), notice: 'Dose was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def set_dose
    @dose = Dose.find(params[:id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
