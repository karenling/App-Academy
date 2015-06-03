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

    Backbone.history.navigate("/pokemon/" + pokemonId, { trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
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
    console.log("lweajflew");
    var toyId = $(event.currentTarget).data("id");
    var pokemonId = $(event.currentTarget).data("pokemon-id");


    var pokemon = this.model;
    var toy = pokemon.toys().get(toyId);

    var toyDetailView = new Pokedex.Views.ToyDetail({
      model: toy
    })

    toyDetailView.render();

  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var toyDetailTemplate = JST['toyDetail']({
      toy: this.model,
      pokes: [] // TODO update this at the end
    })
    $('.toy-detail').html(toyDetailTemplate);

    return this;
  }
});

//
// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
