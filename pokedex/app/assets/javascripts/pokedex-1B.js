Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $divDetail = $('<div>').addClass('detail');

  var pokemonAttributes = ["name", "attack", "defense", "poke_type", "moves"];

  pokemonAttributes.forEach(function (attribute) {
    var $detail = $('<div>').text(attribute + ": " + pokemon.escape(attribute));
    $divDetail.append($detail);
  });

  var $img = $('<img>').attr("src", pokemon.escape('image_url'));

  $divDetail.prepend($img);
  this.$pokeDetail.html($divDetail);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  // use render pokemon detail on click, event will be on a dom target
  var pokeId = $(event.currentTarget).data('id');
  var pokemon = this.pokes.get(pokeId);

  this.renderPokemonDetail(pokemon);
};
