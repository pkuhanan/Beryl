class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :update, :destroy]
  before_action :validate_type!, only: [:create, :update]
  before_action :validate_id!, only: [:update]
  
  # GET /entries
  def index
    authorize Entry
    @entries = index_query

    render json: @entries, include: params[:include], fields: fields_params
  end

  # GET /entries/1
  def show
    authorize @entry
    render json: @entry, include: params[:include], fields: fields_params
  end

  # POST /entries
  def create
    @entry = Entry.new(entry_params)
    authorize @entry
    if @entry.save
      render json: @entry, status: :created, location: @entry
    else
      render json: serialize_errors(@entry), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  def update
    authorize @entry
    if @entry.update(entry_params)
      render json: @entry
    else
      render json: serialize_errors(@entry), status: :unprocessable_entity
    end
  end

  # DELETE /entries/1
  def destroy
    authorize @entry
    @entry.destroy
    render json: @entry
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      attributes = params.require(:data).permit(attributes: policy(Entry).permitted_attributes)
      attributes.merge(relationships)
    end
    
    def relationship_keys
      [:logbook]
    end
    
    def filter_keys
      [:logbook_id]
    end
    
    def fields_keys
      [:logbook, :data_entries]
    end
    
    def sort_keys
      Entry.column_names
    end
end
