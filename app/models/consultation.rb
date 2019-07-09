# == Schema Information
#
# Table name: consultations
#
#  id                    :integer          not null, primary key
#  patient_id            :integer
#  biometric_exam        :text
#  thoracil_exam         :text
#  abdominal_exam        :text
#  members               :text
#  diagnostic_hypothesis :text
#  conduct_adopt         :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  date_done             :date
#

class Consultation < ApplicationRecord
  belongs_to :patient
  has_many_attached :consultation_files

  serialize :biometric_exam, Hash
  store_accessor :biometric_exam, :weight, :height, :imc, :general_state
  serialize :thoracil_exam
  store_accessor :thoracil_exam, :pulmonary_artery, :carotid_artery

  validates_presence_of :date_done

end
