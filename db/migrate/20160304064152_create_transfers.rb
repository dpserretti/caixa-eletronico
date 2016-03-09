class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :origin_account
      t.string :destiny_account
      t.float :value
      t.references :user, index: true, foreign_key: true
      t.string :action
      t.float :tax
      t.string :origin_acc_number
      t.string :destiny_acc_number

      t.timestamps null: false
    end
  end
end
