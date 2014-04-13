class AddIndexes < ActiveRecord::Migration
  def change
    add_index :providers,:npi,:unique=>true
    add_index :payments,:provider_id
    add_index :hcpcs,:code
  end
end
