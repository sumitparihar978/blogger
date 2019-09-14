// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require bootstrap
//= require moment
//= require moment-timezone.js
//= require moment-timezone-with-data


$(document).on('ready turbolinks:load', function(){
	$(document).trigger('init-momentize');    
});

$(document).off('init-momentize').on('init-momentize', function(e) {
    moment.updateLocale('en', {
        relativeTime: {
            future: "%s",
            past: "%s",
            s: function(number, withoutSuffix, key, isFuture) {
                return (number < 10 ? '0' : '') + number + 's';
            },
            m: "1m",
            mm: function(number, withoutSuffix, key, isFuture) {
                return (number < 10 ? '0' : '') + number + 'm';
            },
            h: "1h",
            hh: "%dh",
            d: "1d",
            dd: "%dd",
            M: "1m",
            MM: "%dm",
            y: "1y",
            yy: "%dy"
        }
    });

    $('[data-momentize]').each(function(index) {
        var m = moment($(this).attr('data-momentize'),
            moment.ISO_8601
        )
        if (m.isValid()) {
            $(this).html('<i class="CenterDot"><img src="' + $(this).attr("data-image") + '"></i>  ' + m.fromNow());
            console.log("momentized", index, m.fromNow())
        }
    });

    $('[data-momentiz]').each(function(index) {
        var m = moment($(this).attr('data-momentiz'),
            moment.ISO_8601
        )
        if (m.isValid()) {
            //console.log("momentized", index , m.fromNow());
            $(this).html(m.format('ll'));
        }
    });

    $('[data-momentiztime]').each(function(index) {
        var m = moment($(this).attr('data-momentiztime'),
            moment.ISO_8601
        )
        if (m.isValid()) {
            //console.log("momentized", index , m.fromNow());
            $(this).html(m.format('LT'));
        }
    });
});


setInterval(()=>{
    $(document).trigger('init-momentize');
}, 25*1000)