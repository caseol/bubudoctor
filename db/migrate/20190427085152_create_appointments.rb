class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key: true
      t.references :patient, foreign_key: true
      t.datetime :appointment_date
      t.string :appointment_kind
      t.string :status
      t.text :obs
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
