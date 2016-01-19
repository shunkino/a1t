class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :personName, null:false
      t.string :twitter, null:false
      t.integer :place_id
      t.string :password_digest, null:false

      t.timestamps null: false
    end
  end
end
