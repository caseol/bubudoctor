class Patient < ApplicationRecord
  has_many :appointments
  #has_many :users, through: :appointments
  belongs_to :user

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

end
