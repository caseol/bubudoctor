class CreateDiseases < ActiveRecord::Migration[5.2]
  def change
    create_table :diseases do |t|
      t.string :code
      t.string :name
      t.string :description
      t.string :icd

      t.timestamps
    end
  end
end
