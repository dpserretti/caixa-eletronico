class AddCampoToTransfer < ActiveRecord::Migration
  def change
    add_column :transfers, :new_balance, :float
    add_column :transfers, :origin_acc_number, :string
    add_column :transfers, :destiny_acc_number, :string
  end
end
