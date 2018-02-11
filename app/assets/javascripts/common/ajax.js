$(document).on('ready turbolinks:load', function() {
  $('.js-form-ajax').on('ajax:before', function() {
    $('.ajax-replace-field').html('<div class="ajax-loading"></div>');
  }).on('ajax:complete', function() {
  });
  $('.turbolinks-loading').hide();
}).on('page:fetch', function() {
  $('.turbolinks-loading').show();
}).on('page:restore', function() {
  $('.turbolinks-loading').hide();
});