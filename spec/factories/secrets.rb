FactoryGirl.define do
  factory :secret do
    title { FFaker::Product.product_name }
	published false
	description "My secret..."
  	user_id "1"
  end

end
