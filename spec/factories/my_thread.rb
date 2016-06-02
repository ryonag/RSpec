FactoryGirl.define do

  factory :my_thread do
    # title { Faker::Name.name }
    title "hoge"

  end


=begin
  after(:create) do |thread|
    3.times do
      create(:my_comment, my_thread: my_thread)
    end
  end
=end
end