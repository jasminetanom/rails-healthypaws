//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .


// $(document).ready(function() {
//   $(document).on('click', 'button#add_ingredient', function(event) {
//     var ingredients = [];
//     $('.ingredient_name').forEach(function(selector) {
//       console.log(selector.val());
//     });
//     $('.ingredient_amount').forEach(function(selector) {
//       console.log(selector.val());
//     });
//   });
// });

// $('.ingredient_name').prop('disabled', true/false);
// console.log(ingredients[Number(ids[i]) - 1]);
//

// Object.keys(totalNutrients).forEach(function(nutrient) {
//     totalNutrients[nutrient] = totalNutrients[nutrient] + toAddNutrients[nutrient]
//   });

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





