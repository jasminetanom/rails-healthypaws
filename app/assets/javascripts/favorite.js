function showAndHideStarMessage() {
  $('.favorite-msg').addClass('favorite-msg-tog');

  setTimeout(function() {
    $('.favorite-msg').removeClass('favorite-msg-tog')
  }, 1000);
}

function unselectStar() {
  $('.favorite-star').removeClass('active');

  setTimeout(function() {
    $('span').removeClass('fa-star')
    $('span').addClass('fa-star-o')
  }, 15);
}

function selectStar() {
  $('.favorite-star').addClass('active');
  setTimeout(function() {
    $('span').addClass('fa-star')
    $('span').removeClass('fa-star-o')
  }, 150);
}

function markRecipeAsFavorited(recipeId, callback) {
  $.ajax({
    url: '/recipes/' + recipeId + '/favorite',
    method: 'PUT',
    success: function(data) {
      callback();
    },
    error: function(err) {
      if (err.status) {
        window.location = '/users/sign_in';
      }
    }
  });
}

function markRecipeAsUnfavorited(recipeId, callback) {
  $.ajax({
    url: '/recipes/' + recipeId + '/unfavorite',
    method: 'PUT',
    success: function(data) {
      console.log('success');
      callback();
    },
    error: function() {
      console.log('error');
    }
  });
}

$('.favorite-star').click(function() {
  var recipeId = $(this).data('recipe-id');
  if ($('span').hasClass("fa-star")) {
    var callback = function() {
      unselectStar();
    };

    markRecipeAsUnfavorited(recipeId, callback);
  } else {
    var callback = function() {
      selectStar();
      showAndHideStarMessage();
    };
    markRecipeAsFavorited(recipeId, callback);
  }
})

