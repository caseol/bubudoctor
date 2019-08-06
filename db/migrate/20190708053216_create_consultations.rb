class CreateConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :consultations do |t|
      t.references :patient, foreign_key: true
      t.date :date_done
      t.text :main_complain
      t.text :biometric_exam
      t.text :thoracil_exam
      t.text :abdominal_exam
      t.text :members
      t.text :diagnostic_hypothesis
      t.text :conduct_adopt

      t.timestamps
    end
  end
end
