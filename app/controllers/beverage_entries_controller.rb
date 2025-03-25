class BeverageEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_beverage_entry, only: [:show, :edit, :update, :destroy]

  def index
    @beverage_entries = current_user.beverage_entries.order(consumed_at: :desc)
  end

  def new
    @beverage_entry = current_user.beverage_entries.build
  end

  def show
  end

  def edit
  end

  def create
    @beverage_entry = current_user.beverage_entries.build(beverage_entry_params)
    
    if @beverage_entry.save
      respond_to do |format|
        format.turbo_stream
        redirect_to beverage_entry_path(@beverage_entry), notice: 'Entry was created.'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @beverage_entry.update(beverage_entry_params)
      redirect_to @beverage_entry, notice: 'Beverage entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @beverage_entry.destroy
    redirect_to beverage_entries_url, notice: 'Beverage entry was successfully destroyed.'
  end

  private

  def set_beverage_entry
    @beverage_entry = current_user.beverage_entries.find(params[:id])
  end

  def beverage_entry_params
    params.require(:beverage_entry).permit(
      :consumed_at,
      :category,
      :subcategory,
      :quantity,
      :quantity_unit,
      :temperature,
      :notes,
      :photo,
      additions: []
    )
  end
end
