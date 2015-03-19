class Student < ActiveRecord::Base
  has_secure_password
  belongs_to :group
  has_many   :studentSchedules
  has_many   :schedules, through: :studentSchedules
end
