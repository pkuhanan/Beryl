require "rails_helper"  

RSpec.describe UsersController do  
  before do
    authenticate_user(api_user)
  end
  
  describe "PUT/PATCH update" do
    let(:api_user) { FactoryGirl.create(:user) }
    
    let(:other_user) { FactoryGirl.create(:user) }
    let(:id)         { other_user.id }
    let(:type)       { other_user.model_name.param_key }
    let(:attributes) { {email: "new@email.com"} }

    context 'when trying to update a different user' do
      subject { controller }
      
      before do 
        patch "/users/#{id}", json_api_params("user", attributes, id) 
      end

      it 'responds with 403' do
        expect(last_response.status).to eq 403
      end
    end
  end
end  