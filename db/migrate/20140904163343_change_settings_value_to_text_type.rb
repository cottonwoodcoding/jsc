class ChangeSettingsValueToTextType < ActiveRecord::Migration
  def change
    change_column :settings, :value, :text
  end
end
