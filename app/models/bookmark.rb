class Bookmark < ActiveRecord::Base
  belongs_to :book
  belongs_to :chapter

  before_save :min_offset

  def min_offset
    offset <= 0 ? 0 : offset
  end
end
