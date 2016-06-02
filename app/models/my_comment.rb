class MyComment < ActiveRecord::Base
  belongs_to :my_thread
  validates :content, presence: true
end
