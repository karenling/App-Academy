TrelloClone.Views.CardForm = Backbone.View.extend({
  template: JST['cards/form'],

  events: {
    "submit form": "createCard"
  },

  render: function () {

    var content = this.template({ list: this.model });
    this.$el.html(content);
    return this;
  },

  createCard: function (event) {
    event.preventDefault();
    if ($(event.currentTarget).find('#card-description').val() === "") {
      $(event.currentTarget).find('#card-description').attr("placeholder", "Cannot be empty.");
      console.log("lejwalkfew");
    } else {

    var $form = $(event.currentTarget);

    var attrs = $(event.currentTarget).serializeJSON();
    var card = new TrelloClone.Models.Card();


      card.save(attrs, {
        success: function() {
          this.collection.add(card);
          $form.find('#card-description').val("");
        }.bind(this),
        error: function(models, response) {
          $('.card-errors').html(response.responseJSON[0]);
          console.log(card.validationError());

        }
      });
    }

  }
});
