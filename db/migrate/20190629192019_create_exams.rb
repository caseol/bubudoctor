class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.references :patient, foreign_key: true
      t.string :title
      t.text :conclusion
      t.text :exam_table
      t.datetime :date_done

      t.timestamps
    end
  end
end
