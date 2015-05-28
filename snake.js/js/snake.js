(function() {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var Snake = SnakeGame.Snake = function() {
    this.dir = "S";
    this.segments = [new Coord(1, 1)];
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
    this.segments.pop();
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
    this.dimensions = [40, 40];
    this.snake = new Snake();
  };

  Board.prototype.render = function() {
    var grid = [];
    for (var i = 0; i < this.dimensions[1]; i++) {
      grid.push(Array(this.dimensions[0]+1).join('.'));
    }

    this.snake.segments.forEach(function(element, idx) {
      var newStr = Board.stringReplace(grid[element.yCoord], element.xCoord, "S");
      grid[element.yCoord] = newStr;
    });

    return grid.join("\n");
  };

  Board.stringReplace = function(string, idx, char) {
    return string.substr(0, idx) + char + string.substr(idx + char.length);
  };
})();
