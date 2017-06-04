class LogbooksController < ApplicationController
  before_action :set_logbook, only: [:show, :update, :destroy]
  before_action :validate_type!, only: [:create, :update]
  before_action :validate_id!, only: [:update]
  
  # GET /logbooks
  def index
    authorize Logbook
    @logbooks = index_query

    render json: @logbooks, include: params[:include], fields: fields_params
  end

  # GET /logbooks/1
  def show
    authorize @logbook
    render json: @logbook, include: params[:include], fields: fields_params
  end

  # POST /logbooks
  def create
    @logbook = Logbook.new(logbook_params)
    authorize @logbook
     
    if @logbook.save
      render json: @logbook, status: :created, location: @logbook
    else
      render json: serialize_errors(@logbook), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logbooks/1
  def update
    authorize @logbook
    if @logbook.update(logbook_params)
      render json: @logbook
    else
      render json: serialize_errors(@logbook), status: :unprocessable_entity
    end
  end

  # DELETE /logbooks/1
  def destroy
    authorize @logbook
    @logbook.destroy
    render json: @logbook
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logbook
      @logbook = authorize Logbook.find(params[:id])
    end
    
    def logbook_params
      attributes = params.require(:data).permit(attributes: policy(Logbook).permitted_attributes)
      attributes.merge(relationships)
    end
    
    def relationship_keys
      [:user, :columns]
    end
    
    def filter_keys
      [:name, :user_id]
    end
    
    def fields_keys
      [:user, :entries, :columns]
    end
    
    def sort_keys
      Logbook.column_names
    end
end
