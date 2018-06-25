class CreateWithdraws < ActiveRecord::Migration[5.2]
  def change
    create_table :withdraws do |t|
      t.decimal :amount
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
