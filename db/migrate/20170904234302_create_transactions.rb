class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :source_account_id
      t.integer :destination_account_id
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
