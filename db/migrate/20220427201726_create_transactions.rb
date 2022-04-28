class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :operation
      t.decimal :value, precision: 8, scale: 2
      t.integer :amount
      t.text :pokemon

      t.timestamps
    end
  end
end
