$(document).ready(function() {
    $(function() {
        setTimeout(updateCookbookBuildStageStatus, 10000);
    });
});

function updateCookbookBuildStageStatus () {
    var changeset = $("#cookbooks-build").attr("data-id");
    var project = $("#cookbooks-build").attr("data-project");
    $.getScript("/projects/" + project +"/changesets/" + changeset + "/stage_status.js?stage=0")
    setTimeout(updateCookbookBuildStageStatus, 10000);
}

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