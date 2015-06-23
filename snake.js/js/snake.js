(function() {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var Snake = SnakeGame.Snake = function(board) {
    this.board = board;
    this.dir = "S";
    this.segments = [new Coord(1, 1)];
    this.leftToGrow = 0;
    this.score = 0;
  };

  Snake.prototype.move = function() {
    var directions = {
        "N": [0, -1],
        "E": [1, 0],
        "S": [0, 1],
        "W": [-1, 0]
    };
    var newCoord = this.segments[0].plus(directions[this.dir]);
    this.segments.unshift(newCoord);
    if (this.leftToGrow === 0) {
      this.segments.pop();
    } else {
      this.leftToGrow -= 1;
    }
    if (this.segments[0].equals(this.board.apple.coord)) {
      this.leftToGrow += 3;
      this.score += 10;
      this.board.newApple();
    }
    this.segments.forEach(function(segmentCoord, idx) {
      if ((this.segments[0].equals(segmentCoord)) && (idx !== 0)) {
        alert("Ran into self");
        this.board.loseGame();
      }
    }.bind(this))
  };

  Snake.prototype.turn = function(newDirection) {
    this.dir = newDirection;
  };


  var Coord = SnakeGame.Coord = function(x, y) {
    this.xCoord = x;
    this.yCoord = y;
  };

  Coord.prototype.plus = function (delta) {
    return new Coord(this.xCoord + delta[0], this.yCoord + delta[1]);
  };

  Coord.prototype.equals = function (other) {
    return (this.xCoord === other.xCoord && this.yCoord === other.yCoord);
  };

  Coord.prototype.isOpposite = function (coordinate) {

  };


  var Board = SnakeGame.Board = function() {
    this.dimensions = [20, 20];
    this.snake = new Snake(this);
    this.newApple();
  };

  Board.stringReplace = function(string, idx, char) {
    return string.substr(0, idx) + char + string.substr(idx + char.length);
  };

  Board.prototype.newApple = function() {
    this.apple = new SnakeGame.Apple(Math.floor(Math.random()*20), Math.floor(Math.random()*20));
  };

  var Apple = SnakeGame.Apple = function(xCoord, yCoord) {
    this.coord = new Coord(xCoord, yCoord);
  }
})();
