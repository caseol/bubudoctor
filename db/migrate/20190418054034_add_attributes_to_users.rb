class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :parent, :integer
    add_column :users, :name, :string
    add_column :users, :role, :integer
    add_column :users, :mobile, :string
    add_column :users, :cpf, :string
    add_column :users, :crm, :string
    add_column :users, :speciality, :string
    add_column :users, :plan, :string
  end
end
