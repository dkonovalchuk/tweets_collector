class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :username

      t.timestamps
    end
  end
end
