class FixProviderTypeColumn < ActiveRecord::Migration
  def change
    rename_column :providers, :type, :specialty
  end
end
