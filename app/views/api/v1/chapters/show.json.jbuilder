json.(@chapter, :id, :name, :content, :author, :book_name)
json.chapter_range do
  json.start @chapter_start
  json.end @chapter_end
end