class ChangeDatatypeTwitterOfPerson < ActiveRecord::Migration
  def change
		add_index :people, :twitter, :unique => true
  end
end
