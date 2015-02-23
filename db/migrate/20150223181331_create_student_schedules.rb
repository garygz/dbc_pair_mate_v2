class CreateStudentSchedules < ActiveRecord::Migration
  def change
    create_table :student_schedules do |t|
      t.references  :student, null: false, index: true
      t.references  :schedule, null: false, index: true
      t.references  :group, null: false, index: true
      t.integer     :pair_student_id, index: true
      t.boolean     :is_cancelled, default: false

      t.timestamps
    end
  end
end
