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
    // Add spin class to Refresh buttons
    $('.refresh-btn').click(function () {
        $(this).find('i').addClass('fa-spin');
    });
    // Add spin and disable 'play' button
    $('.btn-start-process').click(function () {
        var i = $(this).find('i');
        i.removeClass('fa-play');
        i.addClass('fa-spin fa-refresh');
    });
}

$(function() {
    assignRefreshReaction();
});