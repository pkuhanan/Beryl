require 'rails_helper'

describe LogbookPolicy do
  subject { described_class.new(api_user, resource) }

  let(:logbook1)        { FactoryGirl.create(:logbook) }
  let(:logbook2)        { FactoryGirl.create(:logbook) }
  let(:private_logbook) { FactoryGirl.create(:private_logbook) }
  let(:admin_user)      { FactoryGirl.create(:admin_user) }
  
  let(:api_user) { logbook1.user }
  let(:resource) { logbook1 }
  
  it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }

  context 'when the record does not belong to the user' do
    let(:api_user) { logbook1.user }
    let(:resource) { logbook2 }
    
    it { is_expected.to permit_actions([:index, :show]) }
    it { is_expected.to forbid_actions([:create, :update, :destroy]) }
    
    context 'when the logbook is not private' do
      let(:resource) { private_logbook }
      
      it { is_expected.to permit_action(:index) }
      it { is_expected.to forbid_actions([:show, :create, :update, :destroy]) }
    end
    
    context 'when user is an administrator' do
      let(:api_user) { admin_user }
  
      it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
    end
  end
  
  describe 'scope' do
    subject { described_class::Scope.new(api_user, Logbook.all).resolve }
    
    it { is_expected.to include(logbook1) }
    it { is_expected.to include(logbook2) }
    it { is_expected.not_to include(private_logbook) }

    context 'when user is an administrator' do
      let(:api_user) { admin_user }
  
      it { is_expected.to include(logbook1) }
      it { is_expected.to include(logbook2) }
      it { is_expected.to include(private_logbook) }
    end
  end

end