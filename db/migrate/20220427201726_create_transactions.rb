class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :operation, null: false
      t.decimal :value, precision: 9, scale: 2, null: false
      t.integer :amount, null: false
      t.text :pokemon, null: false

      t.timestamps
    end
  end
end
