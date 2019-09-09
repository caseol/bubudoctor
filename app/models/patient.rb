# == Schema Information
#
# Table name: patients
#
#  id                            :integer          not null, primary key
#  user_id                       :integer
#  patient_since                 :date
#  name                          :string
#  birth                         :date
#  age                           :integer
#  cpf                           :string
#  gender                        :string
#  etnia                         :string
#  civil_status                  :string
#  occupation                    :string
#  scholarity                    :string
#  zip                           :string
#  district                      :string
#  address                       :string
#  city                          :string
#  uf                            :string
#  telephone                     :string
#  mobile                        :string
#  email                         :string
#  indication_by                 :text
#  health_plan                   :string
#  plan_validation               :date
#  plan_number                   :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  history_current_disease       :text
#  previous_pathological_history :text
#  mother_history                :text
#  social_history                :text
#  father_history                :text
#  physiological_history         :text
#

class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :exams, inverse_of: :patient, dependent: :destroy
  #has_many :users, through: :appointments
  belongs_to :user


  serialize :history_current_disease, Hash
  store_accessor :history_current_disease,
                 :main_complaint, :history_of_disease

  serialize :previous_pathological_history, Hash
  store_accessor :previous_pathological_history,
         :suffered_accidents, :have_allergy, :suffers_asthma,:cardiopathies,
                 :previous_surgeries, :convulsions, :diabetes_mellitus, :dyslipidemia,
                 :childhood, :enteropathies, :gastropathy, :previous_hospitalizations,
                 :history_has, :metabolic_diseases, :nephropathy, :pneumopathy, :osteopathy,
                 :thyroid_disease, :suffered_transfusions, :other_diseases, :use_medications

  serialize :mother_history, Hash
  store_accessor :mother_history,
                 :about_mother, :mother_lives, :mother_cardiac, :mother_diabetes,
                        :mother_congenital_disease, :mother_has, :mother_neoplasms, :mother_obesity, :mother_surgeries
  serialize :father_history, Hash
  store_accessor :father_history,
                 :about_father, :father_lives, :father_cardiac, :father_diabetes,
                 :father_congenital_disease, :father_has, :father_neoplasms, :father_obesity, :father_surgeries
  serialize :social_history, Hash
  store_accessor :social_history,
                 :alcoholism, :smoking, :stop_smoking, :ilicit_drugs, :physical_activity, :aerobic_activity, :other_activity
  serialize :physiological_history, Hash
  store_accessor :physiological_history, :sleep_weel, :has_appetite, :intestinal_function, :renal_function, :menstrual_cycle

  attr_accessor :enable_complete_validation

  validates :name, presence: true,
            if: (:enable_complete_validation)
  validates :mobile, presence: true,
            if: (:enable_complete_validation)
  validate :validate_format_of_document_number

  scope :filter, -> (user_id, term) {
    limit(10)
    .where(user_id: user_id)
    .where("name like '%#{term}%' or protocol_number like '%#{term}%' or cpf like '%#{term}%' or email like '%#{term}%' or birth like '%#{term}%'")
    .order(protocol_number: :desc)
  }


  GENDER = {
      male: "Masculino",
      female: "Feminino",
      not_informed: "Não Informado"
  }

  CIVIL_STATUS = {
      single: "Solteiro(a)",
      married:  "Casado(a)",
      divorcied: "Divorciado(a)",
      spared: "Separado(a)",
      widow: "Viúvo(a)"
  }

  ETNIA= {
      branco: "Branco",
      negro:  "Negro",
      indigena: "Indígena",
      pardo: "Pardo",
      mulato: "Mulato",
      caboclos: "Caboclo",
      cafuzo: "Cafuzo"
  }

  SCHOLARITY = {
      none: "Nenhuma",
      first_degree_incomplete: "1o Grau Incompleto",
      first_degree: "1o Grau",
      second_degree_incomplete: "2o Grau Incompleto",
      second_degree: "2o Grau",
      third_degree_incomplete: "3o Grau Incompleto",
      third_degree: "3o Grau",
      pos_mda: "Pós Graduação/MBA",
      master_degree: "Mestrado",
      doctorate_degree: "Doutorado",
      pos_doctorate: "Pós Doutorado"
  }

  def options
    OpenStruct.new self[:options] || {}
  end

  def validate_format_of_document_number(cpf=self.cpf)
    if (enable_complete_validation)
      return errors.add(:cpf, " não é válido") if cpf.nil?

      nulos = %w{12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000}
      valor = cpf.scan /[0-9]/
      if valor.length == 11
        unless nulos.member?(valor.join)
          valor = valor.collect{|x| x.to_i}
          soma = 10*valor[0]+9*valor[1]+8*valor[2]+7*valor[3]+6*valor[4]+5*valor[5]+4*valor[6]+3*valor[7]+2*valor[8]
          soma = soma - (11 * (soma/11))
          resultado1 = (soma == 0 or soma == 1) ? 0 : 11 - soma
          if resultado1 == valor[9]
            soma = valor[0]*11+valor[1]*10+valor[2]*9+valor[3]*8+valor[4]*7+valor[5]*6+valor[6]*5+valor[7]*4+valor[8]*3+valor[9]*2
            soma = soma - (11 * (soma/11))
            resultado2 = (soma == 0 or soma == 1) ? 0 : 11 - soma
            return true if resultado2 == valor[10] # CPF válido
          end
        end
      end
      return errors.add(:cpf, " não é válido")# CPF inválido
    end
  else
    return true
  end
end
