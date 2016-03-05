class AddFieldsToTransfer < ActiveRecord::Migration
  def change
    add_column :transfers, :action, :string
  end
end
