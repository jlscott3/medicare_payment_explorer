class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :provider_id
      t.string :place_of_service,limit:1
      t.string :hcpcs_code,limit:5
      t.integer :line_srvc_cnt
      t.integer :bene_unique_cnt
      t.integer :bene_day_srvc_cnt
      t.integer :avg_mc_allowed_amt
      t.integer :stdev_mc_allowed_amt
      t.integer :avg_sub_chrg_amt
      t.integer :stdev_sub_chrg_amt
      t.integer :avg_mc_pmt_amt
      t.integer :stdev_mc_pmt_amt

      t.timestamps
    end

    create_table :hcpcs do |t|
      t.string :code,limit:5
      t.string :description,limit:30

      t.timestamps
    end
  end
end
