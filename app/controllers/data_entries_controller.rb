class DataEntriesController < ApplicationController
  before_action :set_data_entry, only: [:show, :update, :destroy]
  before_action :validate_type!, only: [:create, :update]
  before_action :validate_id!, only: [:update]

  # GET /data_entries
  def index
    authorize DataEntry
    @data_entries = index_query

    render json: @data_entries, include: params[:include], fields: fields_params
  end

  # GET /data_entries/1
  def show
    authorize @data_entry
    render json: @data_entry, include: params[:include], fields: fields_params
  end

  # POST /data_entries
  def create
    @data_entry = DataEntry.new(data_entry_params)
    authorize @data_entry
    if @data_entry.save
      render json: @data_entry, status: :created, location: @data_entry
    else
      render json: serialize_errors(@data_entry), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /data_entries/1
  def update
    authorize @data_entry
    if @data_entry.update(data_entry_params)
      render json: @data_entry
    else
      render json: serialize_errors(@data_entry), status: :unprocessable_entity
    end
  end

  # DELETE /data_entries/1
  def destroy
    authorize @data_entry
    @data_entry.destroy
    render json: @data_entry
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_entry
      @data_entry = DataEntry.find(params[:id])
    end
    
    def data_entry_params
      attributes = params.require(:data).permit(attributes: policy(DataEntry).permitted_attributes)
      attributes.merge(relationships)
    end
    
    def relationship_keys
      [:entry, column]
    end
    
    def filter_keys
      [:entry_id, :column_id, :data]
    end
    
    def fields_keys
      [:entries, :columns, :data_entries]
    end
    
    def sort_keys
      DataEntry.column_names
    end
end
