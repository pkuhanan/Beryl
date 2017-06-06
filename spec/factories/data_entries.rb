FactoryGirl.define do
  sequence :data do |n|
    "Data#{n}"
  end

  factory :data_entry do
    data
    entry
    column
    
    factory :private_data_entry do
      association :entry, factory: :private_entry
    end
    
    after(:build) { |object| object.logbook.columns << object.column }
  end
end
