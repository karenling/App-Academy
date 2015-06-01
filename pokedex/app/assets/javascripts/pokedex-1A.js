Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {

  var $li = $('<li>')
    .addClass('poke-list-item')
    .html(pokemon.escape('name') + " " + pokemon.escape('poke_type'));

  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  this.pokes.fetch();
  console.log(this.pokes);
  this.pokes.forEach(console.log);
  this.pokes.forEach(function (pokemon) {
    this.addPokemonToList(pokemon);
    console.log(pokemon.id);
  });
};
