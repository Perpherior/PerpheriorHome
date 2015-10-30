json.count @total
json.data do
  json.array! @books, :id, :name, :author, :word_count, :category, :has_bookmark, :bookmark_chapter_id
end
