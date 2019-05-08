# == Schema Information
#
# Table name: patients
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  patient_since   :date
#  name            :string
#  birth           :date
#  age             :integer
#  cpf             :string
#  gender          :string
#  etnia           :string
#  civil_status    :string
#  occupation      :string
#  scholarity      :integer
#  zip             :string
#  district        :string
#  address         :string
#  city            :string
#  uf              :string
#  telephone       :string
#  mobile          :string
#  email           :string
#  indication_by   :text
#  health_plan     :string
#  plan_validation :date
#  plan_number     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  #has_many :users, through: :appointments
  belongs_to :user

  validates_presence_of :email, :mobile
  validate :validate_format_of_document_number

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

  def validate_format_of_document_number(cpf=self.cpf)
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
end
