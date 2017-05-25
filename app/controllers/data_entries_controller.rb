class DataEntriesController < ApplicationController
  before_action :set_data_entry, only: [:show, :update, :destroy]

  # GET /data_entries
  def index
    @data_entries = DataEntry.all

    render json: @data_entries
  end

  # GET /data_entries/1
  def show
    render json: @data_entry
  end

  # POST /data_entries
  def create
    @data_entry = DataEntry.new(data_entry_params)

    if @data_entry.save
      render json: @data_entry, status: :created, location: @data_entry
    else
      render json: @data_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /data_entries/1
  def update
    if @data_entry.update(data_entry_params)
      render json: @data_entry
    else
      render json: @data_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /data_entries/1
  def destroy
    @data_entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_entry
      @data_entry = DataEntry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def data_entry_params
      params.require(:data_entry).permit(:entry_id, :column_id, :data)
    end
end
