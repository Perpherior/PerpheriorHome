json.(@chapter, :id, :name, :content)
json.chapter_range do
  json.start @chapter_start
  json.end @chapter_end
end