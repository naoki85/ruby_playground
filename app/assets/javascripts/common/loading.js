$(document).on('ready turbolinks:load', function() {
  $('.js-form-ajax').on('ajax:before', function() {
    $('.ajax-replace-field').html('<div class="progress"><div class="indeterminate"></div></div>');
  }).on('ajax:complete', function() {
  });
  $('.turbolinks-loading').removeClass('active');
}).on('page:fetch', function() {
  $('.turbolinks-loading').addClass('active');
}).on('page:restore', function() {
  $('.turbolinks-loading').removeClass('active');
});