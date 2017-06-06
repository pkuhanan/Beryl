FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
  sequence :token do |n|
    "token#{n}"
  end

  factory :user do
    email
    name "Test Name"
    password "password"
    token 
    
    factory :admin_user do
      admin true
    end
  end
end
