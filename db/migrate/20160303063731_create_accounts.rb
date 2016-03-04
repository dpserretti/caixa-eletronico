class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :users, index: true, foreign_key: true
      t.string :number
      t.float :balance
      t.string :status

      t.timestamps null: false
    end
  end
end