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
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require chosen-jquery
//= require bootstrap-select
//= require filterrific/filterrific-jquery
//= require highcharts
//= require chartkick
//= require Chart.bundle
//= require turbolinks
//= require cocoon
//= require moment
//= require moment/es 
//= require bootstrap-switch
//= require bootstrap-datetimepicker
//= require bootstrap-sprockets
//= require bootstrap
//= require bootstrap.min
//= require_tree .

// Se oculta el flash message
window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove();
    });
}, 10000);

$('[data-toggle="tooltip"]').tooltip({
    'selector': '',
    'container':'body'
  });

$(document).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip({
    'selector': '',
    'container':'body'
  });

  // Se oculta el flash message
  window.setTimeout(function() {
    $(".alert").fadeTo(500, 0).slideUp(500, function(){
      $(this).remove();
    });
  }, 10000);

  // Return confirmation modal
  $('#return-confirm').on('show', function() {
    var $submit = $(this).find('.btn-warning'),
    href = $submit.attr('href');
    $submit.attr('href', href.replace('pony', $(this).data('id')));
  });

  $('.return-confirm').click(function(e) {
    e.preventDefault();
    $('#return-confirm').data('id', $(this).data('id')).modal('show');
  });
});