
class AddPhoneWorkAndMobileWorkToPatient < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :telephone_work, :string
    add_column :patients, :mobile_work, :string
  end
end
