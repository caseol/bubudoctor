# == Schema Information
#
# Table name: patients
#
#  id                            :bigint           not null, primary key
#  user_id                       :bigint
#  protocol_number               :integer
#  patient_since                 :date
#  name                          :string(255)
#  birth                         :date
#  age                           :integer
#  cpf                           :string(255)
#  gender                        :string(255)
#  etnia                         :string(255)
#  civil_status                  :string(255)
#  occupation                    :string(255)
#  scholarity                    :string(255)
#  zip                           :string(255)
#  district                      :string(255)
#  address                       :string(255)
#  city                          :string(255)
#  uf                            :string(255)
#  telephone                     :string(255)
#  mobile                        :string(255)
#  email                         :string(255)
#  indication_by                 :text(65535)
#  health_plan                   :string(255)
#  plan_validation               :date
#  plan_number                   :string(255)
#  history_current_disease       :text(65535)
#  previous_pathological_history :text(65535)
#  mother_history                :text(65535)
#  father_history                :text(65535)
#  social_history                :text(65535)
#  physiological_history         :text(65535)
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  health_insurance              :string(255)
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

  validates :name, presence: true
  validate :mobile_or_telephone
  validate :validate_format_of_document_number

  scope :filter, -> (user_id, term, order_field, order_dir) {
    limit(15)
    .where(user_id: user_id)
    .where("name like '%#{term.tr(" ", "%")}%' or protocol_number like '#{term}%' or cpf like '#{term}%' or email like '%#{term}%' or birth like '%#{term}%'")
    .order("#{order_field} #{order_dir}")
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

  HEALTH_INSURANCE= {
      cortesia: "Cortesia",
      particular: "Particular",
      amil: "Amil",
      bradesco: "Bradesco",
      cassi: "CASSI",
      embratel_claro: "Embratel-CLARO",
      embratel_pame: "Embratel-PAME",
      embratel_telos: "Embratel-TELOS",
      petrobras_ams: "Petrobras-AMS",
      petrobras_di: "Petrobras-DI",
      sulamerica: "Sulamérica",
      unimed: "Unimed"
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

  def mobile_or_telephone
    if (enable_complete_validation && (self.mobile.blank? || self.telephone.blank?))
      return errors.add(:mobile, " não pode ficar em branco")
    else
      return true
    end
  end

  def validate_format_of_document_number(cpf=self.cpf)
    if (enable_complete_validation || !cpf.blank?)
      return errors.add(:cpf, " não é válido") if cpf.blank?
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
