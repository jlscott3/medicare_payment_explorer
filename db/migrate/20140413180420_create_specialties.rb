class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.string :name,limit:43
      t.integer :count
      
      t.timestamps
    end
  end
end
