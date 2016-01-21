if @place != nil
	json.response "ok"
	json.type "main"
	json.joined_size @place.people.length
	json.set! :data do 
		json.set! :beacon do
			json.uuid @place.beaconUUID
			json.name @place.placeName
		end
		json.set! :joined_user do 
			json.array! @place.people, :id, :personName, :twitter
		end
	end
else
	json.response "error"
end
