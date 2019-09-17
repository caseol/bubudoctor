# == Schema Information
#
# Table name: consultations
#
#  id                    :bigint           not null, primary key
#  patient_id            :bigint
#  main_complain         :text(65535)
#  date_done             :date
#  biometric_exam        :text(65535)
#  thoracil_exam         :text(65535)
#  abdominal_exam        :text(65535)
#  members               :text(65535)
#  diagnostic_hypothesis :text(65535)
#  conduct_adopt         :text(65535)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
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
