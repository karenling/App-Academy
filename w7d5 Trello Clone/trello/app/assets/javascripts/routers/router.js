TrelloClone.Routers.Boards = Backbone.Router.extend({

  routes: {
    "": "index",
    "boards/:id": "showBoard"
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.boards = new TrelloClone.Collections.Boards();
  },

  index: function() {
    this.boards.fetch();

    var boardIndexView = new TrelloClone.Views.BoardsIndex({
      collection: this.boards
    });
    this.$rootEl.html(boardIndexView.render().$el);
  },

  showBoard: function(id) {
    this.boards.fetch();
    var boardModel = this.boards.getOrFetch(id);
    var newModel = new TrelloClone.Models.Board({id: id});
    newModel.fetch();
    var boardShowView = new TrelloClone.Views.BoardsShow({
      model: newModel
    })
    this.$rootEl.html(boardShowView.render().$el)
  }
});
