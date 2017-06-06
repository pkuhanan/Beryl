FactoryGirl.define do
  sequence :name do |n|
    "Name #{n}"
  end

  factory :logbook do
    name
    description "Test Description"
    user 
    
    factory :private_logbook do
      private true
    end
  end
end
