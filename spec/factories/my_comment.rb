
FactoryGirl.define do

  factory :my_comment do
    association :my_thread
    content "commentcomment"

  end

end