class ColumnsController < ApplicationController
  before_action :set_column, only: [:show, :update, :destroy]
  before_action :validate_type!, only: [:create, :update]
  before_action :validate_id!, only: [:update]

  # GET /columns
  def index
    authorize Column
    @columns = index_query
    
    render json: @columns, include: params[:include], fields: fields_params
  end

  # GET /columns/1
  def show
    authorize @column
    render json: @column, include: params[:include], fields: fields_params
  end

  # POST /columns
  def create
    @column = Column.new(column_params)
    authorize @column
    if @column.save
      render json: @column, status: :created, location: @column
    else
      render json: serialize_errors(@column), status: :unprocessable_entity
    end
  end
  
  def destroy
    authorize @column
    @column.destroy
    render json: @column
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end
    
    def column_params
      attributes = params.require(:data).permit(attributes: policy(Column).permitted_attributes)
      attributes.merge(relationships)
    end
    
    def filter_keys
      [:name, :data_type]
    end
    
    def fields_keys
      [:logbooks, :data_entries]
    end
    
    def sort_keys
      Column.column_names
    end
end
