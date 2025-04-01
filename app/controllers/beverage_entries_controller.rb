class BeverageEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_beverage_entry, only: [:show, :edit, :update, :destroy]

  def index
    @beverage_entries = current_user.beverage_entries.order(consumed_at: :desc).limit(20)
  end

  def new
    @beverage_entry = current_user.beverage_entries.build
    @beverage_entry.build_symptom
  end

  def show
  end

  def edit
    @beverage_entry.build_symptom if @beverage_entry.symptom.nil?
  end

  def create
    @beverage_entry = current_user.beverage_entries.build(beverage_entry_params)
    if @beverage_entry.save
      respond_to do |format|
        format.turbo_stream { redirect_to beverage_entry_path(@beverage_entry), notice: 'Entry was created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new, status: :unprocessable_entity, notice: @beverage_entry.errors }
      end
    end
  end

  def update
    if @beverage_entry.update(beverage_entry_params)
      respond_to do |format|
        format.turbo_stream { redirect_to @beverage_entry, notice: 'Beverage entry was successfully updated.' }
      end
      # redirect_to @beverage_entry, notice: 'Beverage entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @beverage_entry.destroy
    respond_to do |format|
      format.turbo_stream { redirect_to beverage_entries_url, notice: 'Beverage entry was successfully destroyed.' }
    end
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
      :symptoms_occurred,
      additions: [],
      symptoms_attributes: [
        :id, 
        :severity, 
        :onset_time, 
        :other_symptom, 
        :_destroy, 
        { name: [] }
      ]
    )
  end
end
