class CreateMealLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_logs do |t|
      t.date :meal_date
      t.boolean :breakfast
      t.boolean :lunch
      t.boolean :dinner

      t.references :user, foreign_key: true
    end
  end
end
