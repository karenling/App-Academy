var ticTacToe = require("./ttt");

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var game = new ticTacToe.Game(reader);
game.run(function(victor) { console.log(victor + " has won!"); });
