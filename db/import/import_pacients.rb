# -*- encoding : utf-8 -*-
#!/usr/bin/env ruby
require 'spreadsheet'
ENV["RAILS_ENV"] ||= "development"
require File.expand_path("config/environment")

def self.read_sheet(sheet)
  sheet.each_with_index do |row, index|
    #row_cont = row_cont + 1
    #p row_cont
    if false #index == 0 || index == 1
      p "Eliminando cabeçalhos..."
    else
      # pega cada linha e cria um nome paciente
      patient = Patient.new()
      patient.user_id= 6
      patient.name = row[7]
      patient.email= row[22]
      #patient.patient_since= Date::strptime(row[1], "%Y-%m-%d") unless row[1].blank?
      patient.patient_since= row[1] unless row[1].blank?
      #patient.birth= Date::strptime(row[8], "%Y-%m-%d") unless row[8].blank?
      patient.birth= row[8] unless row[8].blank?
      patient.age= row[9]
      patient.cpf= row[14]
      patient.gender= row[10].to_s == '1' ? Patient::GENDER[:male] : (row[10].to_s == '2' ? Patient::GENDER[:female] : '')
      patient.etnia
      patient.civil_status
      patient.occupation= row[13].to_s.upcase
      patient.scholarity
      patient.zip= row[19]
      patient.district= row[17]
      patient.address= row[15]
      patient.city= row[18]
      patient.uf= row[20]
      patient.telephone= row[26]
      patient.mobile= row[27]
      patient.indication_by= row[23]
      patient.health_plan
      patient.plan_validation
      patient.plan_number= row[4]

      patient.save(validate: false)

      p "#{patient.name}|#{patient.email}|#{patient.birth}|#{patient.patient_since}"
    end
  end
end

inicio = DateTime.now()
p "INICIO #{inicio}
  "
import_file_path = File.join(Rails.root, 'db', 'source')

#descriptions = CSV.read(File.join(import_file_path, 'categories_description.csv'), "r:ISO-8859-15:UTF-8")
p "Caminho da aplicação: #{import_file_path}"


book = Spreadsheet.open "#{import_file_path}/pacientes.xls"
#p book.worksheets.size
sheet = book.worksheets[0]
#team_scale = book.worksheets[1]
#team_rx = book.worksheets[2]
#fem_scale = book.worksheets[3]
#masc_scale = book.worksheets[4]
#fem_rx = book.worksheets[5]
#mas_rx = book.worksheets[6]

# apaga todos os atletlas existentes
p "Qtd de PACIENTES: #{sheet.count}"
read_sheet(sheet)
