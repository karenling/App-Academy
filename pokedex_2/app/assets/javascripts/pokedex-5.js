Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.collection.fetch();
    console.log(this.collection);
    this.listenTo(this.collection, "sync", this.render.bind(this));
    this.listenTo(this.collection, "add", this.addPokemonToList.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var pokemonContent = JST['pokemonListItem']({ pokemon: pokemon });
    this.$el.append(pokemonContent);
  },

  refreshPokemon: function (options) {
  },

  render: function () {
    this.$el.empty();

    this.collection.each(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
  },

  selectPokemonFromList: function (event) {
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
  },

  refreshPokemon: function (options) {
  },

  render: function () {
  },

  selectToyFromList: function (event) {
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
  }
});


$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
