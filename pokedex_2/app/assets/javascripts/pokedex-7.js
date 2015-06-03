Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form.new-pokemon": "savePokemon"
  },

  render: function () {
    console.log("rendering form view");
    var formContent = JST["pokemonForm"]({ });
    this.$el.html(formContent);
    return this;
  },

  savePokemon: function (event) {
    event.preventDefault();
    var formValues = $(event.currentTarget).serializeJSON().pokemon;
    this.model.save(formValues, {
      success: function () {
        console.log("saved " + this.model)
        this.collection.add(this.model);
        Backbone.history.navigate("pokemon/" + this.model.id, { trigger: true} );
      }.bind(this)
    });
  }
});
