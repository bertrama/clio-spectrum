class CreateDatabaseAlerts < ActiveRecord::Migration
  def change
    create_table :database_alerts do |t|
      t.integer :clio_id
      t.integer :author_id
      t.boolean :active
      t.text :message

      t.timestamps
    end
  end
end
