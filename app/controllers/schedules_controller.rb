class SchedulesController < ApplicationController
#          Prefix Verb   URI Pattern                                    Controller#Action
#     group_schedules GET    /groups/:group_id/schedules(.:format)          schedules#index
#                     POST   /groups/:group_id/schedules(.:format)          schedules#create
#  new_group_schedule GET    /groups/:group_id/schedules/new(.:format)      schedules#new
# edit_group_schedule GET    /groups/:group_id/schedules/:id/edit(.:format) schedules#edit
#      group_schedule GET    /groups/:group_id/schedules/:id(.:format)      schedules#show
#                     PATCH  /groups/:group_id/schedules/:id(.:format)      schedules#update
#                     PUT    /groups/:group_id/schedules/:id(.:format)      schedules#update
#                     DELETE /groups/:group_id/schedules/:id(.:format)      schedules#destroy


@message = nil


  def index
    id = params[:group_id]
    p "id #{id}"
    schedules = StudentSchedule.select( "student_schedules.*").joins(:schedule)
                                  .where( :student_schedules =>{group_id: id, pair_student_id: nil},
                                          :schedules=> {start_datetime: Time.now..(Time.now.midnight+14.day)})

    @listings = group_by_date_of_week(schedules)
    @group_id = id;

  end

  def new
      details = JSON.parse(params[:timeslot]);
      group_id = params[:group_id]
      begin
        st_time = DateTime.strptime(details["unparsedString"], '%m/%d %I:%M %p')
        end_time = st_time + 1.hour
        agenda = details["agenda"]
        p "st_time: #{st_time}"

        schedule = StudentSchedule.create_new(current_user, st_time,end_time, agenda, group_id);
      rescue Exception => e
        print e;
        render json: {error: e.to_s}
      end

      render json: {path: "/groups/#{group_id}/schedules"}
  end

  def destroy
      s_id = params[:id]
      group_id = params[:group_id]

      begin
      schedule = StudentSchedule.find(s_id);
      if schedule.student.id == current_user.id
        schedule.delete_this_record
        render json: {path: "/groups/#{group_id}/schedules"}
      else
         render json: {
          error: "Not authorized to accept this schedule",
          status: 401
        },status: 401 #not authorized
      end
    rescue Exception => e
      print e;
      render  json: {
        error: "No such schedule",
        status: 404
      }, status: 404
      #not found
    end

  end

  def update
      s_id = params[:id]
      group_id = params[:group_id]

    begin
      schedule = StudentSchedule.find(s_id);
      if(schedule.pair_student == nil)
        schedule.pair_student = current_user
        schedule.save
        render json: {path: "/groups/#{group_id}/schedules"}
      else
         render json: {
          error: "Schedule is already accepted",
          status: 401
        },status: 401 #not authorized
      end
    rescue Exception => e
      print e;
      render  json: {
        error: "No such schedule",
        status: 404
      }, status: 404
      #not found
    end

  end

  private

  def group_by_date_of_week(schedules)
    map_out = {}

    schedules.each do |studentschedule|
      list = map_out.fetch(studentschedule.schedule.to_date_of_week, [])
      list<<studentschedule
      list.sort_by {|studentschedule| studentschedule.schedule.start_datetime}.reverse
      map_out[studentschedule.schedule.to_date_of_week] = list
    end
    map_out
  end

end
