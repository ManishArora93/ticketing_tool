class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :status_type
      t.boolean :is_valid

      t.timestamps null: false
    end
  end
end
