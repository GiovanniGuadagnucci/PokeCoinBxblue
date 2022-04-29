class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name, null: false
      t.integer :base_experience, null: false
      t.string :sprite, null: false

      t.timestamps
    end
  end
end
