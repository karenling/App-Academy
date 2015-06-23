function Board() {
  var grid = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']];

  this.print = function() {
    grid.forEach(function(el) {
      var row = [];
      el.forEach(function(rowElement) {
        row.push(rowElement);
      });
      console.log(row);
    });
  };

  this.markBoard = function (x, y, playerMark) {
    if (grid[x][y] === '-') {
      grid[x][y] = playerMark;
      return true;
    }
    return false;
  };

  this.checkHorizontal = function(playerMark) {
    for (var row = 0 ; row < grid.length ; row++ ){
      var winner = true;
      for (var col = 0; col < grid.length ; col++){
        if (grid[row][col] !== playerMark){
          winner = false;
        }
      }
      if (winner){
        return true;
      }
    }
    return false;
  };

  this.checkVertical = function(playerMark) {
    for (var col = 0 ; col < grid.length ; col++ ){
      var winner = true;
      for (var row = 0; row < grid.length ; row++){
        if (grid[row][col] !== playerMark){
          winner = false;
        }
      }
      if (winner){
        return true;
      }
    }
    return false;
  };

  this.checkDiagonal = function(playerMark) {
    if (grid[0][0] === grid[1][1] && grid[1][1] === grid[2][2] && grid[0][0] === playerMark){
      return true;
    }
    if (grid[2][0] === grid[1][1] && grid[1][1] === grid[0][2] && grid[2][0] === playerMark){
      return true;
    }
    return false;
  };

  this.won = function(playerMark) {
    if (this.checkDiagonal(playerMark) || this.checkVertical(playerMark) || this.checkHorizontal(playerMark)){
      return true;
    }
    return false;
  };

  this.winner = function(){
    if (this.won('x')){
      return ('x');
    }
    else if (this.won('o')){
      return ('o');
    }
    else{
      return null;
    }
  };
}

module.exports = Board;
