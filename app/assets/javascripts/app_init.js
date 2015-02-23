$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
    if($('#calendar').length>0){
      $('#calendar').fullCalendar({
        // put your options and callbacks here
        })
    }

    $("body").on("click", "#add_button", function(e){
        dispatchEvent(new CustomEvent("add_button_clicked", {detail:e}));
    });


    $("body").on("click", ".accept_schedule", function(e){
        dispatchEvent(new CustomEvent("accept_schedule_clicked", {detail:e}));
    });

    $("body").on("click", ".delete_schedule", function(e){
        dispatchEvent(new CustomEvent("delete_schedule_clicked", {detail:e}));
    });


    $("body").on("change", "#schedule-time-inputs", function(e){
        dispatchEvent(new CustomEvent("datetime_changed", {detail:e}));
    });

    $("body").on("change" ,"#schedule-agenda-inputs", function(e){
        dispatchEvent(new CustomEvent("agenda_changed", {detail:e}));
    });

    $("body").on("click", "#submit_schedule_button", function(e){
        dispatchEvent(new CustomEvent("submit_clicked", {detail:e}));
    });

    // if($('#schedule-time-inputs').length>0){
    //   var options = {};
    //   $('#schedule-time-inputs').timepicker(options);
    // }

});

