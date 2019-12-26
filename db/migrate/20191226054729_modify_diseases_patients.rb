class ModifyDiseasesPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :diseases_patients, :id, :primary_key
    add_timestamps :diseases_patients, null: false, default: -> { 'NOW()' }
  end
end
