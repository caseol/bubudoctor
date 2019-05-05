# == Schema Information
#
# Table name: appointments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  patient_id       :integer
#  appointment_date :datetime
#  appointment_kind :string
#  status           :string
#  obs              :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :patient

  enum appointment_kinds: [:first_time, :return, :show_exam, :procedure]
  enum status_kinds: [:scheduled, :done, :absence, :canceled]
  # Uso na view:
  # <%#= f.select(:appointment_kind, Appointment.appointment_kind.keys.collect { |apk| [Appointment.human_enum_name(:appointment_kind, apk), apk] }, {}, class: "form-control") %>
end
