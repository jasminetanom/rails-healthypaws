//
// Vendors
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require cocoon
//= require vendors/bootstrap-slider.min
//
// Custom
//
//= require tabs
//= require favorite


$(function(){

  $(".tab").on("click", function(e){
    // Change active tab
    $(".tab").removeClass('active');
    $(this).addClass('active');
    // Hide all tab-content (use class="hidden")
    $(".tab-content").addClass('hidden');
    // Show target tab-content (use class="hidden")
    $($(this).data('target')).removeClass('hidden');
  });

});


