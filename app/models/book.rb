class Book < ActiveRecord::Base
  belongs_to :admin
  has_many :chapters
end
