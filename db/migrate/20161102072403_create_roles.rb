class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :title
      t.boolean :view_all_users
      t.boolean :create_tickets
      t.boolean :view_all_tickets
      t.boolean :view_own_tickets
      t.boolean :manage_users
      t.boolean :change_own_tickets_status
      t.boolean :change_all_tickets_status
      t.boolean :assign_tickets

      t.timestamps null: false
    end
  end
end
