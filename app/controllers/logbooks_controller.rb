class LogbooksController < ApplicationController
  before_action :set_logbook, only: [:show, :update, :destroy]

  # GET /logbooks
  def index
    @logbooks = Logbook.all

    render json: @logbooks
  end

  # GET /logbooks/1
  def show
    render json: @logbook
  end

  # POST /logbooks
  def create
    @logbook = Logbook.new(logbook_params.merge(:user => current_user))

    if @logbook.save
      render json: @logbook, status: :created, location: @logbook
    else
      render json: @logbook.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logbooks/1
  def update
    if @logbook.update(logbook_params)
      render json: @logbook
    else
      render json: @logbook.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logbooks/1
  def destroy
    @logbook.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logbook
      @logbook = Logbook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def logbook_params
      params.require(:logbook).permit(:name, :description, :private)
    end
end
