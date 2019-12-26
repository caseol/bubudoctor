class Disease < ApplicationRecord
  #has_and_belongs_to_many :patients
  has_many :diseases_patients
  has_many :patients, through: :diseases_patients, dependent: :destroy

end
