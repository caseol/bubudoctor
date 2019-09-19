# == Schema Information
#
# Table name: appointments
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  patient_id       :bigint
#  appointment_date :datetime
#  appointment_kind :string(255)
#  status           :string(255)
#  obs              :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :patient

  attr_accessor :empty_collumn

  scope :filter, -> (user_id, term, beginning, finishing, order_field, order_dir) {
    where(user_id: user_id)
    .joins(:patient)
    .where("patients.name like '%#{term.tr(" ", "%")}%' or patients.protocol_number like '#{term}%' or patients.cpf like '#{term}%' or patients.email like '%#{term}%'")
    .or("appointments.kind like '%#{term.tr(" ", "%")}%'")
    .or("appointment_date between (#{beginning}) and (#{finishing})")
    .order("#{order_field} #{order_dir}")
  }

  enum appointment_kinds: [:first_time, :return, :show_exam, :procedure]
  enum status_kinds: [:scheduled, :done, :absence, :canceled]
  # Uso na view:
  # <%#= f.select(:appointment_kind, Appointment.appointment_kind.keys.collect { |apk| [Appointment.human_enum_name(:appointment_kind, apk), apk] }, {}, class: "form-control") %>

  validates_presence_of :patient, :appointment_date, :appointment_kind, :user
  validates_uniqueness_of :appointment_date, scope: :user_id, allow_nil: true, allow_blank: true, message: "Horário já preenchido!"

end
