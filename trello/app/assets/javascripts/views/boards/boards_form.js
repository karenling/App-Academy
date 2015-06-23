TrelloClone.Views.BoardForm = Backbone.View.extend({
  template: JST['boards/new_board_form'],
  className: "board-form",
  events: {
    "submit form": "submitBoard"
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    
    return this;
  },

  submitBoard: function(event) {
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON();
    var newBoard = new TrelloClone.Models.Board();
    newBoard.save(attrs, {
      success: function() {
        this.collection.add(newBoard);
        Backbone.history.navigate("#boards/" + newBoard.id, { trigger: true });
      }.bind(this),

      error: function(model, response) {
        $('.errors').html(response.responseJSON[0]);
      }
    });
  }

});
