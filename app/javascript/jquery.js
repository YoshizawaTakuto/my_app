$(document).on('turbolinks:load', function() {
    $('#show-btn').on('click', function() {
        if ($('#show-btn').hasClass('open')){
            $('#show-btn').removeClass('open')
            $('#show-nav').slideUp();
        } else {
            $('#show-btn').addClass('open')
            $('#show-nav').slideDown();
        }
    });
});