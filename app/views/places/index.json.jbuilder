json.array!(@places) do |place|
  json.extract! place, :id, :beaconUUID, :placeName, :latitude, :longitude, :pictureData, :pictureType
  json.url place_url(place, format: :json)
end
