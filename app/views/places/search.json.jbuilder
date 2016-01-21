if @places != nil
	json.response "ok"
	json.type "search"
	json.size @places.length
	json.data @places do |place|
		json.extract! place, :id, :placeName, :latitude, :longitude 
		json.picUrl picture_place_path(place)
	end
else
	json.response "error"
end
