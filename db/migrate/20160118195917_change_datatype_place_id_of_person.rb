class ChangeDatatypePlaceIdOfPerson < ActiveRecord::Migration
  def change
		change_column :people, :place_id, :integer, default: 0
  end
end
