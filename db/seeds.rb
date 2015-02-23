group1 = Group.create({name: "Squirrels"});

userJohn = Student.create({fname: "John", lname: "Smith", email: "js@gmail.com", password: "123", group: group1})
userJenny = Student.create({fname: "Jenny", lname: "Portman", email: "jp@gmail.com", password: "123",group: group1})

schedule1 = Schedule.create({start_datetime: "2015-02-21 17:00:00",end_datetime: "2015-02-21 18:00:00", agenda:"week 1 challenge 1"})
schedule2 = Schedule.create({start_datetime: "2015-02-21 12:00:00",end_datetime: "2015-02-21 13:00:00", agenda:"week 1 challenge 1"})

schedule3 = Schedule.create({start_datetime: "2015-02-21 12:00:00",end_datetime: "2015-02-21 13:00:00", agenda:"week 2 challenge 1"})

schedule11 = Schedule.create({start_datetime: "2015-02-22 17:00:00",end_datetime: "2015-02-22 18:00:00", agenda:"week 3 challenge 2"})
schedule21 = Schedule.create({start_datetime: "2015-02-23 12:00:00",end_datetime: "2015-02-23 13:00:00", agenda:"week 3 challenge 2"})

schedule31 = Schedule.create({start_datetime: "2015-02-23 12:00:00",end_datetime: "2015-02-23 13:00:00", agenda:"week 3 challenge 2"})
schedule32 = Schedule.create({start_datetime: "2015-02-24 12:00:00",end_datetime: "2015-02-23 13:00:00", agenda:"any challenge"})


StudentSchedule.create({student: userJohn, schedule: schedule1, group: userJohn.group})
StudentSchedule.create({student: userJohn, schedule: schedule2, group: userJohn.group})
StudentSchedule.create({student: userJohn, schedule: schedule3, group: userJohn.group})


StudentSchedule.create({student: userJenny, schedule: schedule11, group: userJenny.group})
StudentSchedule.create({student: userJenny, schedule: schedule21, group: userJenny.group})
StudentSchedule.create({student: userJenny, schedule: schedule31, group: userJenny.group})

StudentSchedule.create({student: userJohn, schedule: schedule32, group: userJohn.group})

