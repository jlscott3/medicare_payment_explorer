class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :npi,limit:8
      t.string :last_org_name,limit:70
      t.string :first_name,limit:20
      t.string :mi,limit:1
      t.string :credentials,limit:20
      t.string :gender,limit:1
      t.string :entity_code,limit:1
      t.string :street1,limit:55
      t.string :street2,limit:55
      t.string :city,limit:40
      t.string :zip,limit:20
      t.string :state,limit:2
      t.string :country,limit:2
      t.string :type,limit:43
      t.string :mc_participation,limit:1

      t.timestamps
    end
  end
end
