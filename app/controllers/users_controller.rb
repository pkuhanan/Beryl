class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create], raise: false
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :validate_type!, only: [:create, :update]
  before_action :validate_id!, only: [:update]
  
  # GET /users
  def index
    @users = index_query

    render json: @users, include: params[:include], fields: fields_params
  end

  # GET /users/1
  def show
    render json: @user, include: params[:include], fields: fields_params
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: serialize_errors(@user), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: serialize_errors(@user), status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      attributes = params.require(:data).permit(attributes: [:email, :name, :password]).fetch(:attributes, {})
      attributes.merge(relationships)
    end
    
    def relationship_keys
      [:logbook]
    end
    
    def filter_keys
      [:name, :email]
    end
    
    def fields_keys
      [:logbooks]
    end
    
    def sort_keys
      User.column_names
    end
end
