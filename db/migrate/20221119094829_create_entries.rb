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
      t.datetime   :created_at, null: false
      t.datetime   :updated_at, null: false
      t.datetime   :deleted_at
    end

    add_index :entries, :deleted_at
  end
end
