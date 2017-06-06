require 'rails_helper'

describe DataEntryPolicy do
  subject { described_class.new(api_user, resource) }

  let(:data_entry1)        { FactoryGirl.create(:data_entry) }
  let(:data_entry2)        { FactoryGirl.create(:data_entry) }
  let(:private_data_entry) { FactoryGirl.create(:private_data_entry) }
  let(:admin_user)         { FactoryGirl.create(:admin_user) }
  
  let(:api_user) { data_entry1.user }
  let(:resource) { data_entry1 }
  
  it { is_expected.to permit_actions([:show, :create, :update, :destroy]) }
  it { is_expected.to forbid_action(:index) }

  context 'when the record does not belong to the user' do
    let(:api_user) { data_entry1.user }
    let(:resource) { data_entry2 }
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions([:index, :create, :update, :destroy]) }
    
    context 'when the data_entry is not private' do
      let(:resource) { private_data_entry }
      
      it { is_expected.to forbid_actions([:index, :show, :create, :update, :destroy]) }
    end
    
    context 'when user is an administrator' do
      let(:api_user) { admin_user }
  
      it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
    end
  end
  
  describe 'scope' do
    subject { described_class::Scope.new(api_user, DataEntry.all).resolve }
    
    it { is_expected.to include(data_entry1) }
    it { is_expected.to include(data_entry2) }
  end
end