(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var view = this;
    $('.cell').on('click', function(event){

      var $cell = $(event.currentTarget);
      var pos = $cell.data("pos");

      if (view.game.board.isEmptyPos(pos)) {
        view.makeMove($cell);
        view.game.playMove(pos);
        if (view.game.isOver()) {
          $('.cell').off('click').addClass('marked');
          var winner = view.game.winner();
          var message;
          if (winner === null) {
            message = "It's a draw! =(";
          } else {
            console.log("Hi");
            message = "You win, " + winner + "!";

            var winningLine = view.game.board.winningPositions();
            console.log(winningLine);

            winningLine.forEach(function (position) {
              $('.cell').each(function (idx, el) {
                if ($(el).data('pos').toString() === position.toString() ) {
                  $(el).addClass('winning');
                }
              });
            });
          }
          view.$el.after($('<div>').addClass('message').text(message));
        }
      } else {
        alert('Invalid move!');
      }
    });
  };

  View.prototype.makeMove = function ($square) {
    $square.addClass('marked');
    $square.text(this.game.currentPlayer);
    if (this.game.currentPlayer === 'x') {
      $square.addClass('marked-x');
    } else {
      $square.addClass('marked-o');
    }
  };

  View.prototype.setupBoard = function () {
    for(var i = 0; i < 3; i++) {
      this.$el.append($('<div>').addClass('row').addClass('group'));
    }
    for(var j = 0; j < 3; j++) {
      $('.row').append($('<div>').addClass('cell'));
    }
    $('.cell').each(function(idx, el) {
      $(el).data("pos", [Math.floor(idx / 3), idx % 3]);
    });
  };


})();
