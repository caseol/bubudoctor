class CreateDiseasesPatientsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :diseases, :patients do |t|
      t.index :disease_id
      t.index :patient_id
    end
  end
end
