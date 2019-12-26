class DiseasesPatient < ApplicationRecord
  belongs_to :patient
  belongs_to :disease
end
