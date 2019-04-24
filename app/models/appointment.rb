# == Schema Information
#
# Table name: appointments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  patient_id       :integer
#  appointment_date :datetime
#  status           :string
#  obs              :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Appointment < ApplicationRecord
end
