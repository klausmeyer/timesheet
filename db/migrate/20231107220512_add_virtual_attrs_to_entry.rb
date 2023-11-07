class AddVirtualAttrsToEntry < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :week, :virtual, type: :string, as: "DATE_PART('week', date)", stored: true
    add_column :entries, :year, :virtual, type: :string, as: "DATE_PART('year', date)", stored: true

    add_index :entries, :week
    add_index :entries, :year
  end
end
