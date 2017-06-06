require 'rack/test'
module ApiHelper  
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  def authenticate_user(api_user)
    allow_any_instance_of(ApplicationController).to receive(:authenticate_token).and_return(api_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(api_user)
  end
end  