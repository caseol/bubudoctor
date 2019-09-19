class AddNationalIdentificationAndDescriptionToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :national_identification, :string
    add_column :patients, :description, :text
  end
end
