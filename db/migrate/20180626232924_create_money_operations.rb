class CreateMoneyOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :money_operations do |t|
      t.decimal :amount
      t.string :operation
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
