class AddMobileNoToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :mobile_no, :string
  end
end
