//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .

var ingredients = [
{name:'Chicken breast, skinless, boneless', energy_kcal:1.51,protein_g:0.3054,fat_g:0.0317,fiber_g:0,calcium_mg:0.05,iron_mg:0.0045,magnesium_mg:0.34,phosphorus_mg:2.58,potassium_mg:3.91,sodium_mg:0.52,zinc_mg:0.009,niacin_mg:0.12133,pyridoxine_mg:0.01157,folate_ug:0,vitamin_b12_ug:0.0021,vitamin_a_iu:0.1,vitamin_e_mg:0.0054,vitamin_d_iu:0.01,riboflavin_mg:0.00213,thiamin_mg:0.00107},
{name:'Cheese, Cheddar', energy_kcal:4.04,protein_g:0.2287,fat_g:0.3331,fiber_g:0,calcium_mg:7.1,iron_mg:0.0014,magnesium_mg:0.27,phosphorus_mg:4.55,potassium_mg:0.76,sodium_mg:6.53,zinc_mg:0.0364,niacin_mg:0.00059,pyridoxine_mg:0.00066,folate_ug:0.27,vitamin_b12_ug:0.011,vitamin_a_iu:12.42,vitamin_e_mg:0.0071,vitamin_d_iu:0.24,riboflavin_mg:0.00428,thiamin_mg:0.00029},
{name:'Pacific Cod', energy_kcal:0.85,protein_g:0.1873,fat_g:0.005,fiber_g:0,calcium_mg:0.1,iron_mg:0.002,magnesium_mg:0.24,phosphorus_mg:3.45,potassium_mg:2.89,sodium_mg:3.72,zinc_mg:0.0039,niacin_mg:0.01343,pyridoxine_mg:0.00136,folate_ug:0.08,vitamin_b12_ug:0.0231,vitamin_a_iu:0.07,vitamin_e_mg:00067,vitamin_d_iu:0.24,riboflavin_mg:0.00055,thiamin_mg:0.00038},
{name:'Brocolli', energy_kcal:0.35,protein_g:0.0238,fat_g:0.0041,fiber_g:0.033,calcium_mg:0.4,iron_mg:0.0067,magnesium_mg:0.21,phosphorus_mg:0.67,potassium_mg:2.93,sodium_mg:0.41,zinc_mg:0.0045,niacin_mg:0.00553,pyridoxine_mg:0.002,folate_ug:1.08,vitamin_b12_ug:0,vitamin_a_iu:15.48,vitamin_e_mg:0.0145,vitamin_d_iu:0,riboflavin_mg:0.00123,thiamin_mg:0.00063},
{name:'Quinoa', energy_kcal:1.2,protein_g:0.044,fat_g:0.0192,fiber_g:0.028,calcium_mg:0.17,iron_mg:0.0149,magnesium_mg:0.64,phosphorus_mg:1.52,potassium_mg:1.72,sodium_mg:0.07,zinc_mg:0.0109,niacin_mg:0.00412,pyridoxine_mg:0.00123,folate_ug:0.42,vitamin_b12_ug:0,vitamin_a_iu:0.05,vitamin_e_mg:0.0063,vitamin_d_iu:0,riboflavin_mg:0.0011,thiamin_mg:0.00107},
];

var totalNutrients = {energy_kcal:0,protein_g:0,fat_g:0,fiber_g:0,calcium_mg:0,iron_mg:0,magnesium_mg:0,phosphorus_mg:0,potassium_mg:0,sodium_mg:0,zinc_mg:0,niacin_mg:0,pyridoxine_mg:0,folate_ug:0,vitamin_b12_ug:0,vitamin_a_iu:0,vitamin_e_mg:0,vitamin_d_iu:0,riboflavin_mg:0,thiamin_mg:0}


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
      $('#' + nutrient).html(totalNutrients[nutrient].toString());
    });
  });



});




