FactoryGirl.define do
  factory :secret do
    title { FFaker::Lorem.sentence }
	published false
	description "My secret..."
  	user
  end

end
