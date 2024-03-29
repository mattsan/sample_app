FactoryGirl.define do
  factory :user do
  	sequence(:name)  { |n| "Persion #{n}" }
  	sequence(:email) { |n| "persion_#{n}@example.com" }
  	password "foobar"
  	password_confirmation "foobar"

  	factory :admin do
  	  admin true
  	end
  end

  factory :micropost do
  	content "Lorem ipsum"
  	user
  end
end