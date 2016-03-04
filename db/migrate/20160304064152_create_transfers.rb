class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :origin_account
      t.string :destiny_account
      t.float :value

      t.timestamps null: false
    end
  end
end
