class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :juhe_id
      t.string :name
      t.string :pic

      t.timestamps
    end

    add_index :movies, :juhe_id
  end
end
