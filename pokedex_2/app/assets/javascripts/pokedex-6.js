Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail"
  },

  initialize: function (options) {

  },

  pokemonDetail: function (id, callback) {
    console.log(id);
    console.log(this._pokemonIndex.collection);

    console.log(this._pokemonIndex.collection.fetch());
    console.log(this._pokemonIndex.collection);
    console.log(this._pokemonIndex.collection.get(id));

    var pokemon = this._pokemonIndex.collection.get(id);
    var pokemonDetailView = new Pokedex.Views.PokemonDetail({
      model: pokemon
    });

    $("#pokedex .pokemon-detail").html(pokemonDetailView.$el);
    // pokemonDetailView.render();
    pokemonDetailView.refreshPokemon();
  },

  pokemonIndex: function (callback) {
    var pokemonIndex = new Pokedex.Views.PokemonIndex();
    pokemonIndex.refreshPokemon();
    $("#pokedex .pokemon-list").html(pokemonIndex.$el);

    this._pokemonIndex = pokemonIndex;
  },

  toyDetail: function (pokemonId, toyId) {
  },

  pokemonForm: function () {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
