TrelloClone.Views.Card = Backbone.View.extend({
  template: JST['cards/card_item'],
  className: "individual-card",

  initialize: function() {
    this.$el.data("card-id", this.model.id);
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "mouseover": "showDelete",
    "mouseout": "hideDelete",
    "click .card-delete-button": "deleteCard",
    "dropCard": "dropCard",
  },


  dropCard: function(event, index, newListId) {
    this.$el.trigger('updateSortCards', [this.model, index, newListId]); // now that you know the card model and the new position
  },

  render: function() {
    var card = this.model;
    var content = this.template({ card: this.model });
    this.$el.html(content);
    this.$el.find('.card-delete-button').hide();
    return this;
  },

  showDelete: function(event) {
    this.$el.find('.card-delete-button').show();
  },

  hideDelete: function(event) {
    this.$el.find('.card-delete-button').hide();
  },
  deleteCard: function(event) {
    event.preventDefault();
    this.model.destroy();
    this.remove();
  }
});
