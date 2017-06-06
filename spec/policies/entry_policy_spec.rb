require 'rails_helper'

describe EntryPolicy do
  subject { described_class.new(api_user, resource) }

  let(:entry1)        { FactoryGirl.create(:entry) }
  let(:entry2)        { FactoryGirl.create(:entry) }
  let(:private_entry) { FactoryGirl.create(:private_entry) }
  let(:admin_user)    { FactoryGirl.create(:admin_user) }
  
  let(:api_user) { entry1.user }
  let(:resource) { entry1 }
  
  it { is_expected.to permit_actions([:show, :create, :update, :destroy]) }
  it { is_expected.to forbid_action(:index) }

  context 'when the record does not belong to the user' do
    let(:api_user) { entry1.user }
    let(:resource) { entry2 }
    
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions([:index, :create, :update, :destroy]) }
    
    context 'when the entry is not private' do
      let(:resource) { private_entry }
      
      it { is_expected.to forbid_actions([:index, :show, :create, :update, :destroy]) }
    end
    
    context 'when user is an administrator' do
      let(:api_user) { admin_user }
  
      it { is_expected.to permit_actions([:index, :show, :create, :update, :destroy]) }
    end
  end
  
  describe 'scope' do
    subject { described_class::Scope.new(api_user, Entry.all).resolve }
    
    it { is_expected.to include(entry1) }
    it { is_expected.to include(entry2) }
  end
end