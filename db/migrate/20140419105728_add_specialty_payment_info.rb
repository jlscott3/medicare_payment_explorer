class AddSpecialtyPaymentInfo < ActiveRecord::Migration
  def change
    add_column :specialties, :total_pmt, :integer, :limit=>8
    add_column :specialties, :max_pmt, :integer, :limit=>8
    add_column :specialties, :avg_pmt, :integer, :limit=>8
  end
end
