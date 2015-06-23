(function () {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var View = SnakeGame.View = function($el) {
    this.board = new SnakeGame.Board();
    this.$el = $el;
    this.setupBoard();
    $(document).on("keydown", this.handleKeyEvent.bind(this));

    var gameIntervalId = setInterval(this.step.bind(this), 50);

  };

  View.prototype.setupBoard = function() {
    for (var i = 0; i < 20; i++) {
      var newRow = $('<div>').addClass('row');
      for (var j = 0; j < 20; j++) {
        var newCell = $('<div>').addClass('cell').addClass('col-' + j).addClass('row-' + i);
        newRow.append(newCell);
      }
      this.$el.append(newRow);
    }
  };

  View.prototype.handleKeyEvent = function(event) {
    var newDirection;
    switch(event.keyCode) {
      case 87:
        newDirection = "N";
        break;
      case 65:
        newDirection = "W";
        break;
      case 83:
        newDirection = "S";
        break;
      case 68:
        newDirection = "E";
        break;
    }
    console.log(event.keyCode);
    if (typeof newDirection !== "undefined") {
      this.board.snake.turn(newDirection);
    }
  };

  View.prototype.render = function () {
    $('.cell').removeClass('has-snake has-apple');

    var coord = this.board.apple.coord;
    $('.col-' + coord.xCoord + '.row-' + coord.yCoord).addClass('has-apple');

    this.board.snake.segments.forEach(function(coord) {
      $('.col-' + coord.xCoord + '.row-' + coord.yCoord).addClass('has-snake');
    })

  };

  View.prototype.step = function () {
    this.board.snake.move();
    this.$el.text(this.render());
  };

})();

// W: 87;
// A: 65;
// S: 83;
// D: 68;
