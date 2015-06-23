TrelloClone.Views.BoardsIndexItem = Backbone.View.extend({

  template: JST['boards/list_item'],
  className: "individual-board",

  initialize: function(options) {
  },
  events: {
    "click .board-index-delete-button": "deleteBoard",
  },



  deleteBoard: function(event) {
    event.preventDefault();
    var deleteView = new TrelloClone.Views.DeleteModal({ model: this.model });
    $('body').append(deleteView.render().$el);
    return this;
  },



  render: function() {
    var board = this.model;
    var content = this.template({ board: board });
    this.$el.html(content);



    return this;
  }

});
