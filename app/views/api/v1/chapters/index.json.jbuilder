json.data do
  json.array! @chapters, :id, :name, :word_count, :book_id, :content
end
