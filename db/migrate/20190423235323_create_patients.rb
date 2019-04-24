class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.date :patient_since
      t.string :name
      t.date :birth
      t.string :age
      t.string :cpf
      t.string :gender
      t.string :etnia
      t.string :civil_status
      t.string :occupation
      t.integer :scholarity
      t.string :zip
      t.string :address
      t.string :district
      t.string :city
      t.string :uf
      t.string :telephone
      t.string :mobile
      t.string :email
      t.text :indication_by
      t.string :health_plan
      t.date :plan_validation
      t.string :plan_number
      t.timestamps
    end
  end
end
