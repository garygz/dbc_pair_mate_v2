class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :start_datetime, null: false, index: true
      t.datetime :end_datetime, null: false, index: true
      t.string :agenda

      t.timestamps
    end
  end
end
