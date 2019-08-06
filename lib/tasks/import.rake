  namespace :import do
    desc "Importa Pacientes"
    task :patients, [:arg1] => :environment do |t, arg|
      p 'Iniciando importação de PACIENTES'
      ruby File.dirname(__FILE__) + "/../../db/import/import_pacients.rb '#{arg[:arg1]}'"
    end
  end
