TrelloClone.Collections.Boards = Backbone.Collection.extend({
  model: TrelloClone.Models.Board,
  url: "/api/boards",


  getOrFetch: function (id) {
    var collection = this;

    var board = collection.get(id);

    if (board)
      board.fetch();
    else {
      board = new TrelloClone.Models.Board({id: id});
      board.fetch({
        success: function() {
          collection.add(board);
        }
      });
    }
    return board;
  }


});
