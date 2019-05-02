class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :patient

  enum appointment_kind: [:first_time, :return, :show_exam, :procedure]
  # Uso na view:
  # <%#= f.select(:appointment_kind, Appointment.appointment_kind.keys.collect { |apk| [Appointment.human_enum_name(:appointment_kind, apk), apk] }, {}, class: "form-control") %>
end
