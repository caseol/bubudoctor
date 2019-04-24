class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key: true, index: true
      t.references :patient, foreign_key: true, index: true

      t.datetime :appointment_date
      t.string :status
      t.text :obs

      t.timestamps
    end
  end
end
