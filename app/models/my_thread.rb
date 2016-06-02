class MyThread < ActiveRecord::Base
  has_many :my_comments, dependent: :destroy
  validates :title, presence: true
end
