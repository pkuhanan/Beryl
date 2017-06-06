require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(api_user, resource) }

  let(:user1)      { FactoryGirl.create(:user) }
  let(:user2)      { FactoryGirl.create(:user) }
  let(:admin_user) { FactoryGirl.create(:admin_user) }
  
  let(:api_user) { user1 }
  let(:resource) { user1 }
  
  it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }

  context 'when the record does not belong to the user' do
    let(:api_user) { user1 }
    let(:resource) { user2 }
    
    it { is_expected.to permit_actions([:index, :show, :create]) }
    it { is_expected.to forbid_actions([:update, :destroy]) }
    
    context 'when user is an administrator' do
      let(:api_user) { admin_user }
  
      it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
    end
  end

  describe 'scope' do
    subject { described_class::Scope.new(api_user, User.all).resolve }
    
    it { is_expected.to include(user1) }
    it { is_expected.to include(user2) }
  end
end