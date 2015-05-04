class Chapter < ActiveRecord::Base
  belongs_to :book

  before_create :count_words

  def count_words
    self.word_count = content.gsub(/\s+/, "").size
  end
end
