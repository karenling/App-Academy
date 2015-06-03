Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
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

    return this;
  },

  selectPokemonFromList: function (event) {
    var pokemonId = $(event.currentTarget).data("id");
    var pokemon = this.collection.get(pokemonId);
    var pokemonDetailView = new Pokedex.Views.PokemonDetail({
      model: pokemon
    });

    $("#pokedex .pokemon-detail").html(pokemonDetailView.$el);
    // pokemonDetailView.render();
    pokemonDetailView.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: this.render.bind(this)

    });
  },

  render: function () {
   var pokemonDetailContent = JST['pokemonDetail']({ pokemon: this.model });
   console.log(this.$el);
   this.$el.html(pokemonDetailContent);
   this.model.toys().each(function (toy) {
     var toyDetailContent = JST['toyListItem']({ toy: toy });
     $('ul.toys').append(toyDetailContent);
   });
   return this;
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
