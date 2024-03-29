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
//= require jquery3
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require chosen-jquery
//= require font_awesome5
//= require popper
//= require moment
//= require moment/es.js
//= require moment-timezone-with-data
//= require tempusdominus-bootstrap-4.js

//= require highcharts/highcharts
//= require highcharts/highcharts-more

//= require chartkick
//= require cocoon
//= require filterrific/filterrific-jquery
//= require bootstrap-switch
//= require bootstrap
//= require bootstrap-select
//= require turbolinks
//= require_tree .

// Se oculta el flash message
window.setTimeout(function() {
  $(".alert").fadeTo(500, 0).slideUp(500, function(){
      $(this).remove();
  });
}, 10000);

$.fn.selectpicker.defaults = {
  selectAllText: 'Todos',
  deselectAllText: 'Ninguno'
};

$('[data-toggle="tooltip"]').tooltip({
  'selector': '',
  'container':'body'
});

$('#filterrific_filter').on(
  "change",
  ":input",
  function (e) {
    e.stopImmediatePropagation();
    $(this).off("blur");
    Filterrific.submitFilterForm;
  }
);

$(document).on('turbolinks:load', function() {

  $('.counter').each(function () {
    $(this).prop('Counter',0).animate({
      Counter: $(this).text()
    }, {
    duration: 4000,
    easing: 'swing',
    step: function (now) {
      $(this).text(Math.ceil(now));
      }
    });
  });

  $('.prevent-enter-form').on('keypress', e => {
      if (e.keyCode == 13) {
          return false;
      }
  });

  $(document).ready(function($) {
    $(".table-row").click(function() {
        window.document.location = $(this).data("href");
    });
  });

  $('#filterrific_filter').on(
    "change",
    ":input",
    function (e) {
    e.stopImmediatePropagation();
    $(this).off("blur");
    Filterrific.submitFilterForm;
    }
  );

  $('.since-date, .to-date, .requested-date, .prescribed-date').datepicker({
    closeText: 'Cerrar',
    prevText: '<Ant',
    nextText: 'Sig>',
    currentText: 'Hoy',
    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
    monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
    dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
    dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
    dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
    weekHeader: 'Sm',
    dateFormat: 'dd/mm/y',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  });

  // Difference in format date
  $('.last-contact-date').datepicker({
    closeText: 'Cerrar',
    prevText: '<Ant',
    nextText: 'Sig>',
    currentText: 'Hoy',
    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
    monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
    dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
    dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
    dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
    weekHeader: 'Sm',
    dateFormat: 'dd/mm/yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  });


  $('.quantity_ord_supply_lots').on('cocoon:after-insert', function(e, insertedItem) {
    $('.selectpicker').selectpicker({style: 'btn-sm btn-default'}); // Se inicializa selectpicker luego de agregar form
  });

  $('.selectpicker').selectpicker({style: 'btn-sm btn-default'}); // Se inicializa selectpicker

  $('.selectpicker-md').selectpicker({style: 'btn-default'});

  $('#since-datepicker').datetimepicker({
    format: 'DD/MM/YYYY',
    locale: 'es'
  });

  $(".required").prop('required', true);

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

  $('#filterrific_with_professional_type_id').chosen({
    allow_single_deselect: true,
    no_results_text: 'No se encontró el resultado',
    width: '150px'
  });

  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No se encontró el resultado',
    width: '200px'
  });

  // aqui se define el formato para el datepicker de la fecha de vencimiento en "solicitar cargar stock"
  $('.external_order_quantity_ord_supply_lots_expiry_date_fake .input-group.date')
  .datetimepicker({
    format: 'MM/YY',
    viewMode: 'months',
    locale: 'es',
    useCurrent: false,
  });
  
  $('.external_order_quantity_ord_supply_lots_expiry_date_fake .input-group.date').on('change.datetimepicker', function(e){
    const inputDate = $(e.target).find('input.datetimepicker-input').first().val();
    if(typeof inputDate !== 'undefined'){
      const td = $(e.target).closest('td');
      const expiryDateFormated = moment(inputDate, "MM/YY");
      $(td).find('input.new-expiry-date-hidden').first().val(expiryDateFormated.endOf("month").format("YYYY-MM-DD"));
    }
  });
  
  $('.external_order_quantity_ord_supply_lots_expiry_date_fake .input-group.date input.datetimepicker-input').on('change', function(e){
    $(e.target).parent().trigger('change.datetimepicker');
  });

  $('.search-lots').click(function (event) {
    var nested_form = $(this).parents(".nested-fields");
    nested_form.find(".select-change").trigger('change');
    nested_form.find('.search-lots').hide();
  });
});

$(document).on('turbolinks:load', function() {

  $("#internal_order_since_date , #internal_order_to_date, #external_order_since_date, #external_order_to_date, #report_since_date, #report_to_date").datetimepicker({
    format: 'DD/MM/YYYY',
    locale: 'es',
    icons: {
      time: "far fa-clock",
    }
  });
});
