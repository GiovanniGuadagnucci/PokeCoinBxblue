class AddWalletReferencesToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :wallet, null: false, foreign_key: true
  end
end
