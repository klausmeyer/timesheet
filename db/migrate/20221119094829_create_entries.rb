class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.string     :type, null: false
      t.references :user, null: false, foreign_key: true
      t.date       :date, null: false
      t.time       :start_time
      t.time       :end_time
      t.decimal    :time_manual
      t.string     :comment

      t.timestamps
    end
  end
end
