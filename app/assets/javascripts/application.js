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
//= require maelstorm
//= require jquery
//= require jquery_ujs
//= require best_in_place
//= require bootstrap
//= require bootstrap-inputmask
//= require bootstrap-markdown
//= require social-share-button
//= require_tree .

$(document).ready(function() {
    if (location.hash !== '') $('a[href="' + location.hash + '"]').tab('show');
    return $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
        return location.hash = $(e.target).attr('href').substr(1);
    });
});
$(document).ready(function() {
    $("[data-href]").click(function() {
        window.document.location = $(this).data("href");
    });
    $(".best_in_place").best_in_place();
    $('.checkbox').checkbox();
    $('.selectpicker').selectpicker();
    $("textarea.markdown").each(function(i,el){
        $(el).markdown({
            savable: $(el).data('savable'),
            onSave: function(e) {
                var url = e.$textarea.data('url');
                var name = e.$textarea.attr('name');
                var field = e.$textarea.data('field');
                $.ajax({
                    method: 'post',
                    url: url,
                    data: Maelstorm.prepareParam(name, e.getContent()),
                    dataType: 'json'
                });
            }
        })
        if($(el).closest('form').length > 0){
            $(el).attr('form', $(el).closest('form').attr('id'));
        }
    });
    $(".add-new-record").bind('ajax:success', function(){window.document.location.reload();});
    $('.registration-selector').on(
        "webkitAnimationEnd oanimationend msAnimationEnd animationend",
        function() {
            $(this).removeClass("success-animation");
        }
    );
    $('.registration-selector').change(function(event){
        var user = $(event.target).data('user');
        var experiment = $(event.target).data('experiment');
        var session = $(event.target).find('option:selected').val();
        var that = this;
        $.ajax({
            method: 'POST',
            url: '/assignments/' + user + ',' + experiment,
            data: {assignment: {current_session: session}},
            dataType: 'json'
        })
            .done(function(){
                $(that).addClass('success-animation');
            });
    })
    $('#calendar').fullCalendar({
        header:{
            left:   'title',
            center: 'month,basicWeek',
            right:  'today prev,next'
        },
        height: 400,
        events: function(start, end, callback) {
            $.ajax({
                url: '/experiments/calendar',
                dataType: 'json',
                data: {
                    // our hypothetical feed requires UNIX timestamps
                    start: Math.round(start.getTime() / 1000),
                    end: Math.round(end.getTime() / 1000)
                },
                success: function(doc) {
                    var events = [];
                    $(doc).each(function() {
                        events.push({
                            title: this['experiment']['name'] + ' by ' +
                                this['experiment']['creator']['last_name'] + ' ' + this['experiment']['creator']['first_name'] +
                                ' in ' + this['lab']['location'] + ', subjects: ' + this['registered_subjects'] + '/' + this['required_subjects'],
                            start: this['start_time'],
                            end: this['end_time'],
                            allDay: false,
                            color: this['finished'] ? '' : 'green',
                            url: '/sessions/' + this['id'] + '/online'
                        });
                    });
                    callback(events);
                }
            });
        },
        timeFormat: {
            agenda: 'H:mm{ - H:mm}',
            '': 'H:mm'
        },
        minTime: '5',
        maxTime: '22'
    })

});

