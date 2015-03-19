class Schedule < ActiveRecord::Base

  def formatTimeSlot
      #%d/%m/%Y
      textOut = start_datetime.strftime("%I:%M %p")
      textOut<<" - "
      textOut << end_datetime.strftime("%I:%M %p")
  end

  def to_date_of_week
     weekDay = start_datetime.strftime("%A")
     weekDay<< " ("<<start_datetime.strftime("%m/%d")<<")"
  end
end
