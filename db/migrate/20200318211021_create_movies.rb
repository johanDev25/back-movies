class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.integer :id_movie
      t.string :title
      t.string :overview
      t.string :vote
      t.string :poster
      t.string :release
      t.timestamps
    end
  end
end
