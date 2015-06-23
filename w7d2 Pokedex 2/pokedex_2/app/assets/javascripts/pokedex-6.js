Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail",
    "pokemon/:id": "pokemonDetail"
  },

  initialize: function (options) {

  },

  pokemonDetail: function (id, callback) {
      console.log('ewjalfkewjl');

    if (this._pokemonIndex) {
      //
      // console.log(id);
      // console.log(this._pokemonIndex.collection);
      //
      // console.log(this._pokemonIndex.collection.fetch());
      // console.log(this._pokemonIndex.collection);
      // console.log(this._pokemonIndex.collection.get(id));
      var pokemon = this._pokemonIndex.collection.get(id);


      var pokemonDetailView = new Pokedex.Views.PokemonDetail({
        model: pokemon
      });

      $("#pokedex .pokemon-detail").html(pokemonDetailView.$el);
      // pokemonDetailView.render();
      pokemonDetailView.refreshPokemon({success: callback});

      this._pokemonDetailView = pokemonDetailView;

    } else if (!this._pokemonIndex) {
      this.pokemonIndex(
        this.pokemonDetail.bind(this, id, callback)
      );
      return;
    }



  },

  pokemonIndex: function (callback) {
    var pokemonIndex = new Pokedex.Views.PokemonIndex();
    pokemonIndex.refreshPokemon({success: callback});
    $("#pokedex .pokemon-list").html(pokemonIndex.$el);

    this._pokemonIndex = pokemonIndex;
    this.pokemonForm();
    // this._pokemonIndex.collection.fetch();
    // console.log(this._pokemonIndex.collection);
  },

  toyDetail: function (pokemonId, toyId) {

    if (this._pokemonDetailView) {
      console.log("ljewalfejwl here with " + pokemonId + "  " + toyId);

      var pokemon = this._pokemonDetailView.model;


      // var pokemon = this.model;
      var toy = pokemon.toys().get(toyId);

      var toyDetailView = new Pokedex.Views.ToyDetail({
        model: toy,
        collection: this._pokemonIndex.collection
      });

      toyDetailView.render();

    } else if (!this._pokemonDetailView) {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
      console.log(" here with " + pokemonId + "  " + toyId);

    }

  },

  pokemonForm: function () {
    console.log("elwjafklew")
    var pokemonFormView = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon (),
      collection: this._pokemonIndex.collection
    });
    pokemonFormView.render();


    $('#pokedex .pokemon-form').html(pokemonFormView.$el);
    pokemonFormView.render();

  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
