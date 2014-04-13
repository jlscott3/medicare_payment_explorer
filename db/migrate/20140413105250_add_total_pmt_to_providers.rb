class AddTotalPmtToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :total_pmt, :integer,:limit=>8
  end
end
