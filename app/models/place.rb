class Place < ActiveRecord::Base
	has_many :people

	def pictureFile= (p)
		if p
			self.pictureData = p.read
			self.pictureType = p.content_type
		end
	end
end
