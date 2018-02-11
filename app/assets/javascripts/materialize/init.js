$(document).on('ready turbolinks:load', function() {
  $('.button-collapse').sideNav();
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15,
    today: 'Today',
    clear: 'Clear',
    close: 'OK',
    closeOnSelect: true,
    format: 'yyyy-mm-dd'
  });
  $('.materialize-textarea').val();
});