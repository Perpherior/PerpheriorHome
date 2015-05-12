class Chapter < ActiveRecord::Base
  belongs_to :book
  has_one :bookmark, dependent: :destroy

  before_create :count_words

  def count_words
    self.word_count = content.gsub(/\s+/, "").size
  end
end
