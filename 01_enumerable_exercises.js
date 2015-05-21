
// ---------------------------------------------------------------------

Array.prototype.myEach = function(passed) {
  for(var i = 0; i < this.length; i++) {
    passed(this[i]);
  }
};

var logIfEven = function(num){
// function logIfEven(num) {
  if ((num % 2) == 0) {
    console.log("Found an even number!");
  }
};

[1, 2, 3, 4].myEach(logIfEven);
