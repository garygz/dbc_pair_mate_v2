class StudentSchedule < ActiveRecord::Base
  belongs_to :student
  belongs_to :schedule
  belongs_to :group
  belongs_to :pair_student, class_name: "Student"

  def delete_this_record
    StudentSchedule.transaction do
        schedule.destroy
        destroy
    end
  end

  class<<self
    def create_new(student, start_datetime, end_datetime, agenda, group_id)
      p "create new schedule"
      StudentSchedule.transaction do
        schedule = Schedule.create({start_datetime: start_datetime, end_datetime: end_datetime, agenda: agenda})
        create({student: student, schedule: schedule, group_id: group_id})
      end
    end
  end
end
