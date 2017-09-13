class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.decimal  :balance, precision: 10, scale: 2

      t.timestamps
    end
  end
end
