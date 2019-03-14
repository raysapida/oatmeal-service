FactoryBot.define do
  factory :tweet do
    full_text { "MyText" }
    screen_name { "MyString" }
    created_at { "2019-03-14 13:34:36" }
  end
end
