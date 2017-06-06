module Requests  
  def json
    JSON.parse(last_response.body)
  end
  
  def json_api_params(type, attributes, id = nil)
    params = {
      data: {
        type: type,
        attribtues: attributes
      }
      
    }
    params[:data][:id] = id if id.present?
    params
  end
end  