class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :user, foreign_key: true
      t.date :date
      t.string :tod

      t.timestamps
    end
    add_index :attendances, [:user_id, :date], unique: true
  end
end
