class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.decimal :daily_working_hours, null: false

      t.timestamps
    end
  end
end
