class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :require_login
  
  def require_login
    authenticate_token || render_unauthorized("Access denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  protected

    def render_unauthorized(message)
      errors = { errors: [ { detail: message } ] }
      render json: errors, status: :unauthorized
    end

  private
  
    def user_not_authorized(exception)
      errors = { errors: [ { detail: "Not authorized to perform this action" } ] }
      render json: errors, status: :forbidden
    end
  
    def model_klass
      self.class.to_s.chomp("Controller").singularize.constantize
    end
  
    def index_query
      query = policy_scope(model_klass).order(sort_params)
      query = query.first(query_params[:limit]) if query_params[:limit].to_i > 0
      query.where(query_params[:filter])
    end

    def authenticate_token
      # Authorization header format: "Authorization: Token token=<your-token-here>"
      authenticate_with_http_token do |token, options|
        User.find_by(token: token)
      end
    end  
    
    def query_params
      params.permit(:limit, :sort, filter: filter_keys, fields: fields_keys)
    end
    
    def fields_params
      fields = query_params[:fields]
      fields.each{ |key,str| fields[key] = str.split(",") } if fields.present?
    end
    
    def sort_params
      validated_sort_params.each_with_object({}) do |attribute, sort_hash|
        if attribute.start_with?('-')
          attribute = attribute[1..-1]
          sort_hash[attribute] = :desc
        else
          sort_hash[attribute] = :asc
        end
      end
    end
    
    def validated_sort_params
      raw_sort_params = query_params.fetch(:sort, "").split(",")
      Rails.logger.debug "@@@@ #{raw_sort_params}"
      valid = raw_sort_params.all? do |key| 
        sort_keys.include?(reverse_chomp(key, "-")) 
      end
      raise ActionController::BadRequest.new("Invalid sort parameter provided") unless valid
      
      raw_sort_params
    end
  
    def reverse_chomp(string, character)
      string.reverse.chomp(character).reverse
    end
    
    def validate_id!
      id = params.require(:data).require(:id)
      raise ActionController::BadRequest.new("Provided id does not match this endpoint") unless id.to_s == params[:id].to_s
    end
    
    def validate_type!
      type = params.require(:data).require(:type)
      raise ActionController::BadRequest.new("Invalid type parameter provided: #{type}") unless type == model_klass.to_s.underscore
    end
    
    def relationships
      relationship_types = relationship_keys || []
      struct = relationship_types.map { |rel| {rel => [:data => [:type, :id]]} }
      relationships = params.permit(:data, relationships: struct).fetch(:relationships, {})

      relationship_types.each_with_object({}) do |rel_key, rel_hash|
        rel_id_key = rel_key.to_s.singularize.concat("_id").to_sym
        rel_data = relationships.dig(rel_key, :data) || {}
        if rel_data.is_a? Array
          rel_id_key = rel_id_key.to_s.pluralize.to_sym
          rel_id = rel_data.map { |rel| rel[:id] }
        else
          rel_id = rel_data[:id]
        end
        
        rel_hash[rel_id_key] = rel_id if rel_id.present?
      end
    end
    
    def serialize_errors(object)
      {errors: ApiExceptions::ErrorSerializer.serialize(object)}
    end
end
