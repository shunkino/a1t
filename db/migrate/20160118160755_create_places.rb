class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :beaconUUID
      t.string :placeName
      t.float :latitude
      t.float :longitude
      t.binary :pictureData
      t.string :pictureType

      t.timestamps null: false
    end
  end
end
