FactoryGirl.define do
  factory :entry do
    logbook
    
    factory :private_entry do
      association :logbook, factory: :private_logbook
    end
  end
end
