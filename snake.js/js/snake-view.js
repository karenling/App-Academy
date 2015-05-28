(function () {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }



  var View = SnakeGame.View = function($el) {
    this.board = new SnakeGame.Board();
    this.$el = $el;

    $(document).on("keydown", this.handleKeyEvent.bind(this));

    setInterval(this.step.bind(this), 500);
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

  View.prototype.step = function () {
    this.board.snake.move();
    this.$el.text(this.board.render());
  };
})();

// W: 87;
// A: 65;
// S: 83;
// D: 68;
