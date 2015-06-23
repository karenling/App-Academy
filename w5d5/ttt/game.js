var Board = require("./board");

function Game(reader) {

  this.board = new Board();
  var playerMark = 'x';
  this.prompt = function(completionCallback) {
    var that = this;
    // below, the board and the prompt are in the same scope (the current game)
    this.board.print();
    var markPos = "";
    reader.question("Player " + playerMark + ", Where would you like to mark?", function(answer) {
      markPos = answer;
      var positions = that.parse(markPos);
      if (that.board.markBoard(positions[0], positions[1], playerMark)){
        that.switchPlayer();
      }
      else{
        console.log("Cannot mark position");
      }
      that.run(completionCallback);
    });
  };

  this.parse = function(markPos) {
    var x = parseInt(markPos.split(",")[0]);
    var y = parseInt(markPos.split(",")[1]);
    return [x,y];
  };
  this.run = function(completionCallback) {
    var victor = this.board.winner();
    if (victor === null){
      this.prompt(completionCallback);
    }
    else{
      completionCallback(victor);
      this.board.print();
      reader.close();
    }
  };

  this.switchPlayer = function(){
    if (playerMark === 'x'){
      playerMark = 'o';
    } else {
      playerMark = 'x';
    }
  };
}

module.exports = Game;
