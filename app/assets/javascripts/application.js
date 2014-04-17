// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require modernizr/modernizr
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require bootstrap-inputmask
//= require_tree .

jQuery('.checkbox').checkbox();
jQuery('.selectpicker').selectpicker();

jQuery(document).ready(function() {
    if (location.hash !== '') $('a[href="' + location.hash + '"]').tab('show');
    return $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
        return location.hash = $(e.target).attr('href').substr(1);
    });
});
jQuery(document).ready(function() {
    $('#calendar').fullCalendar({
        events: function(start, end, callback) {
            $.ajax({
                url: '/calendar',
                dataType: 'json',
                data: {
                    // our hypothetical feed requires UNIX timestamps
                    start: Math.round(start.getTime() / 1000),
                    end: Math.round(end.getTime() / 1000)
                },
                success: function(doc) {
                    var events = [];
                    $(doc).each(function() {
                        st = new Date(this['start_time']);
                        et = new Date(this['end_time']);
                        events.push({
                            title: this['experiment']['name'] + ' by '
                                + this['experiment']['creator']['last_name'] + ' ' + this['experiment']['creator']['first_name'] +
                                ' from '
                                + (st.getHours() < 10 ? '0' + st.getHours() : st.getHours()) + ':'
                                + (st.getMinutes() < 10 ? '0' + st.getMinutes() : st.getMinutes()) +
                                ' to '
                                + (et.getHours() < 10 ? '0' + et.getHours() : et.getHours()) + ':'
                                + (et.getMinutes() < 10 ? '0' + et.getMinutes() : et.getMinutes()),
                            start: this['start_time'],
                            end: this['end_time']
                        });
                    });
                    callback(events);
                }
            });
        },
        timeFormat: 'H(:mm)' // uppercase H for 24-hour clock
    })

});
jQuery(document).ready(function($) {
    $("[data-href]").click(function() {
        window.document.location = $(this).data("href");
    });
    $('.save').click(function(event){
        event.preventDefault();
        $('.save-row').submit();
    })
});
