FactoryBot.define do
  factory :post do
    text_content "Hello World"
    user factory: :user
  end
end
