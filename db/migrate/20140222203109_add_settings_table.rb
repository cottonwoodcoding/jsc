class AddSettingsTable < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.string :value
    end
  end
end
