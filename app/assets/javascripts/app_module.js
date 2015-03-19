var app_module = function(){
    var TimeSlot = function(){
      this.agenda = null;
      this.unparsedString = null;
    }

    TimeSlot.prototype.isDefined = function(){
      return this.unparsedString!=null && this.unparsedString.trim().length>0;
    }

    var timeSlotArg = null;
    var apptDetails = null;

    var redirectWindow = function(path){
      window.location.replace(path);
    }

    var openDialog = function(){
      //this will force creation of new object
      timeSlotArg = null;
      $("#listing-add-new").show();

    }

    var onDateTimeChange = function(e){
      if(timeSlotArg == null){
        timeSlotArg = new TimeSlot();
      }
      timeSlotArg.unparsedString = e.detail.target.value;
    }

    var onAgendaChange = function(e){
      if(timeSlotArg == null){
        timeSlotArg = new TimeSlot();
      }
      timeSlotArg.agenda = e.detail.target.value;
    }


    var onSubmit = function(){
      if(timeSlotArg!=null && timeSlotArg.isDefined()){
        dataOut = JSON.stringify(timeSlotArg);
        $.ajax({
            url: "/groups/"+getCurrentGroupId()+"/schedules/new.json",
            data: {timeslot: dataOut},
            type: "GET",
            dataType: "json",
            success: onSucess,
            error: onError
          });
      }
    }

    var getCurrentGroupId = function(){
      // get this as data attribute from the page
      var id = $("#listing-header").attr("data-group-id");
      return id;
    }

    var addAvialability = function(){

      if (!$("#listing-add-new").is(':visible')){
        $("#add_button").text("Hide Availability Form");
        openDialog();
      }else{
        $("#listing-add-new").hide();
        $("#add_button").text("Add Your Availabilty");
      }


    }

    var onError = function(response){
      console.log(response);
      if (response.status>299){
          var errObject = JSON.parse(response.responseText);
          alert("Your operation HAS FAILED. Error: " + errObject.error);
      }else{
        alert("Your operation HAS FAILED. Contact DBC for help.");
      }

    }

    var onSucess = function(response){
      if (response.error){
        onError(response);
      }else{
        if(apptDetails!=null){
          alert("You have accepted the following appointment:\n" + apptDetails);
          apptDetails = null;
        }

        redirectWindow(response.path);
      }

    }

    var getScheduleIfFromEvent = function(e){
      var target = $(e.detail.currentTarget).closest(".calendar-listing");
      return target.attr("data-id");
    }

    var getDetailsForId = function(id){
      return $("#calendar-listing-"+id).attr("data-details");
    }

    //TODO move this into a helper delete/accept module
    var acceptSchedule = function(e){
      var id = getScheduleIfFromEvent(e);
      apptDetails = getDetailsForId(id);
        $.ajax({
           url: "/groups/"+getCurrentGroupId()+"/schedules/"+id+".json",
            type: "PUT",
            dataType: "json",
            success: onSucess,
            error: onError
        });
    }

    var deleteSchedule = function(e){
       var id = getScheduleIfFromEvent(e);
        $.ajax({
           url: "/groups/"+getCurrentGroupId()+"/schedules/"+id+".json",
            type: "DELETE",
            dataType: "json",
            success: onSucess,
            error: onError
        });
    }


    addEventListener("add_button_clicked", addAvialability);
    addEventListener("accept_schedule_clicked", acceptSchedule);
    addEventListener("delete_schedule_clicked", deleteSchedule);
    addEventListener("submit_clicked", onSubmit);
    addEventListener("datetime_changed", onDateTimeChange);
    addEventListener("agenda_changed", onAgendaChange);
    //no public API - event bus architecture
    return {

    }
}();
