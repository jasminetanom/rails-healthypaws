//
// Vendors
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require cocoon
//
// Custom
//
//= require tabs
//= require favorite



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

$(document).ready(function() {

  $(document).on('click', '#check_recipe', function(event) {
    var ids = [];
    $('.ingredient_name').each(function(i, item) {
      ids.push($(item).val());
    });


    var amounts = [];
    $('.ingredient_amount').each(function(i, item) {
      amounts.push($(item).val());
    });


    Object.keys(totalNutrients).forEach(function(nutrient) {
      totalNutrients[nutrient] = 0
    });


    for (var i = 0; i < ids.length; i += 1) {
      Object.keys(totalNutrients).forEach(function(nutrient) {
        totalNutrients[nutrient] = totalNutrients[nutrient] + ingredients[Number(ids[i]) - 1][nutrient] * amounts[i]
      });
    }

    Object.keys(totalNutrients).forEach(function(nutrient) {
      var percentageValue = Math.round(totalNutrients[nutrient] / $('#' + nutrient + '_val').html() * 100);
      $('#' + nutrient).attr('aria-valuenow', percentageValue);
      $('#' + nutrient + '_percent').html(percentageValue + "%");
      if (percentageValue <= 100) {
        $('#' + nutrient).attr('style', "width: " + percentageValue + "%");
        if (percentageValue <= 50){
          $('#' + nutrient + '_percent').html(percentageValue + "%" + " | Try to increase amount?");
        };
      } else {
        $('#' + nutrient).attr('style', "width: 100%");
        $('#' + nutrient).removeClass('progress-bar-warning');
        $('#' + nutrient).addClass('progress-bar-success');
        if (percentageValue >= 350) {
          $('#' + nutrient + '_percent').html(percentageValue + "%" + " | Try to decrease amount?");
          $('#' + nutrient).removeClass('progress-bar-success');
          $('#' + nutrient).addClass('progress-bar-warning');
        };
      };
    });
  });
});
