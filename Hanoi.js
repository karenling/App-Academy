var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame(numStacks){
  this.stacks = [];
  for (var i = numStacks; i > 0; i--) {
    this.stacks.push(i);
  }

  this.towers = [ this.stacks , [] , [] ];
  this.isWon = function (){
    if (this.towers[0].length === 0){
      if (this.towers[1].length === numStacks || this.towers[2].length === numStacks)
      {
        return true;
      }
    }
    return false;
  };

  this.isValidMove = function (startTowerIdx, endTowerIdx){
    // if start tower is empty, return false
    if (this.towers[startTowerIdx].length === 0) {
      return false;
    } else if (this.towers[endTowerIdx].length === 0) {
      return true;
    }

    var startTower = this.towers[startTowerIdx];
    var endTower = this.towers[endTowerIdx];
    if (startTower[startTower.length - 1] < endTower[endTower.length - 1]) {
      return true;
    } else {
      return false;
    }
  };

  this.move = function (startTowerIdx, endTowerIdx){
    if (this.isValidMove(startTowerIdx, endTowerIdx)) {
      var startTower = this.towers[startTowerIdx];
      var endTower = this.towers[endTowerIdx];
      endTower.push(startTower.pop());
      return true;
    }
    return false;
  };

  this.print = function(){
    console.log(JSON.stringify(this.towers));
  };

  this.promptMove = function (callback, completionCallback){
    this.print();
    var that = this;
    reader.question("where you move from?", function(numString1) {
      reader.question("where you move to?", function(numString2) {
        var startTowerIdx = parseInt(numString1);
        var endTowerIdx = parseInt(numString2);

        var result = callback(startTowerIdx, endTowerIdx);
        if (result === false){
          console.log("Invalid Move");
        }

        that.run(completionCallback);
      });
    });

  };

  this.run = function (completionCallback){
    if (this.isWon()){
      completionCallback();
    } else{
      this.promptMove(this.move.bind(this), completionCallback);
    }
  };
}

var somekindaMethod = function(){
  reader.close();
  console.log("yay you win");
};


var hanoi = new HanoiGame(3);
hanoi.run(somekindaMethod);
