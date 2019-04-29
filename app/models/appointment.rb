class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :patient
  enum appointment_kind: [:first_time, :return, :show_exam, :procedure]
end
