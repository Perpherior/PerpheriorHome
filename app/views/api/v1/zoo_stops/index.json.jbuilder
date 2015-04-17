json.data do
  json.array! @stops, :id, :name, :latitude, :longitude
end
