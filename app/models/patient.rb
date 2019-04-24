# == Schema Information
#
# Table name: patients
#
#  id              :integer          not null, primary key
#  patient_since   :date
#  name            :string
#  birth           :date
#  age             :string
#  cpf             :string
#  gender          :string
#  etnia           :string
#  civil_status    :string
#  occupation      :string
#  scholarity      :integer
#  zip             :string
#  address         :string
#  district        :string
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
  
  GENDER = {
      male: "Masculino",
      female: "Feminino"
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

end
