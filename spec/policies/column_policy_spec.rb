require 'rails_helper'

describe ColumnPolicy do
  subject { described_class.new(api_user, resource) }

  let(:column1)      { FactoryGirl.create(:column) }
  let(:column2)      { FactoryGirl.create(:column) }
    
  let(:user)         { FactoryGirl.create(:user) }
  let(:admin_user)   { FactoryGirl.create(:admin_user) }
  
  let(:api_user) { user }
  let(:resource) { column2 }
  
  it { is_expected.to permit_actions([:index, :show, :create]) }
  it { is_expected.not_to permit_action(:destroy) }
    
  context 'when user is an administrator' do
    let(:api_user) { admin_user }
  
    it { is_expected.to permit_actions([:index, :show, :create, :destroy]) }
  end

  describe 'scope' do
    subject { described_class::Scope.new(api_user, Column.all).resolve }
    
    it { is_expected.to include(column1) }
    it { is_expected.to include(column2) }
  end
end