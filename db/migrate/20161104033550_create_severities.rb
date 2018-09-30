class CreateSeverities < ActiveRecord::Migration
  def change
    create_table :severities do |t|
      t.string :severity_type
      t.boolean :is_valid

      t.timestamps null: false
    end
  end
end
