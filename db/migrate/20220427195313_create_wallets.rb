class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.decimal :balance, default: 1000, precision: 9, scale: 2
      t.text :pokemons

      t.timestamps
    end
  end
end
