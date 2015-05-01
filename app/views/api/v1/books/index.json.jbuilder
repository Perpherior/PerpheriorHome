json.data do
  json.array! @books, :id, :name, :author, :word_count, :category
end
