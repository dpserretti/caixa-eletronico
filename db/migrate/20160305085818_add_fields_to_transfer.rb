class AddFieldsToTransfer < ActiveRecord::Migration
  def change
    add_column :transfers, :user_id, :integer
    add_column :transfers, :action, :string
    add_column :transfers, :tax, :float
    add_column :transfers, :origin_acc_number, :string
    add_column :transfers, :destiny_acc_number, :string
  end
end
