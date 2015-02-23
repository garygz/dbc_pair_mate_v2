class Group < ActiveRecord::Base
  has_many :students
  has_many :studentSchedules
  has_many :schedules, through: :studentSchedules
end
