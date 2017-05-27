//= require jquery
//= require jquery_ujs
//= require back/plugins/slimScroll/jquery.slimscroll.min
//= require back/plugins/pace/pace.min
//= require back/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min
//= require back/plugins/datatables/jquery.dataTables.min
//= require back/plugins/datatables/dataTables.bootstrap.min
//= require back/app
//= require application
//= require bootstrap-sprockets
//= require ace-rails-ap
//= require ace/theme-monokai

$(function() {
    $('textarea[data-editor]').each(function() {
        var textarea = $(this);
        var mode = textarea.data('editor');
        var editDiv = $('<div>', {
            position: 'absolute',
            width: '100%',
            height: '300px',
            'class': textarea.attr('class')
        }).insertBefore(textarea);
        textarea.css('visibility', 'hidden');
        var editor = ace.edit(editDiv[0]);
        editor.getSession().setValue(textarea.val());
        editor.getSession().setMode("ace/mode/" + mode);
        editor.setTheme("ace/theme/monokai");

        // copy back to textarea on form submit...
        textarea.closest('form').submit(function() {
            textarea.val(editor.getSession().getValue());
        })
    });
});

$(document).ready(function() {
  var table = $('.dataTable').DataTable();

  // Get sidebar state from localStorage and add the proper class to body
  $('body').addClass(localStorage.getItem('sidebar-state'));

  var activePage = stripTrailingSlash(window.location.pathname);
  $('.sidebar-menu li a').each(function(){
    var currentPage = stripTrailingSlash($(this).attr('href'));
    if (activePage == currentPage) {
      $(this).closest('.treeview').addClass('active');
      $(this).parent().addClass('active');
    }
  });
  function stripTrailingSlash(str) {
    if(str.substr(-1) == '/') { return str.substr(0, str.length - 1); }
    return str;
  }

  // Save sidebar state in localStorage browser
  $('.sidebar-toggle').on('click', function(){
    if($('body').attr('class').indexOf('sidebar-collapse') != -1) {
      localStorage.setItem('sidebar-state', '');
    } else {
      localStorage.setItem('sidebar-state', 'sidebar-collapse');
    }
  });
});
