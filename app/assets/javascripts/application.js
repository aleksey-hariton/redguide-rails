
function assignRefreshReaction(){
    // Add spin and disable 'play' button
    $('.btn-start-process').click(function () {
        var i = $(this).find('i');
        i.removeClass('fa-bullhorn');
        i.removeClass('fa-play');
        i.removeClass('fa-flash');
        i.addClass('fa-spin fa-refresh');
    });
}

$(function() {
    assignRefreshReaction();
});