class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.text :description
      t.integer :severity
      t.integer :status
      t.integer :customer_id
      t.integer :associate_id

      t.timestamps null: false
    end
  end
end
