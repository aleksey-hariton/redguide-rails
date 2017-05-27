//= require jquery
//= require jquery_ujs
//= require back/plugins/slimScroll/jquery.slimscroll.min
//= require back/plugins/pace/pace.min
//= require back/plugins/morris/morris.min
//= require back/plugins/raphael/raphael-min
//= require back/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min
//= require back/plugins/datatables/jquery.dataTables.min
//= require back/plugins/datatables/dataTables.bootstrap.min
//= require back/app
//= require application
//= require bootstrap-sprockets
//= require ace-rails-ap
//= require ace/theme-monokai

var textarea = ace.edit("editor");
textarea.setTheme("ace/theme/monokai");
textarea.getSession().setMode("ace/mode/javascript");

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
