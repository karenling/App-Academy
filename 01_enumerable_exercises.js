
// ---------------------------------------------------------------------
"use strict";

Array.prototype.myEach = function (passed) {
  for(var i = 0; i < this.length; i++) {
    passed(this[i]);
  }
};

var ifEven = function (num){
// function logIfEven(num) {
  if ((num % 2) == 0) {
    console.log("Found an even number!");
  }
};

// [1, 3, 5, 4].myEach(ifEven);



// ---------------------------------------------------------------------

// Array.prototype.map = function(passed) {
//   this.myEach(passed);
// };

Array.prototype.map = function (passed) {
  numbers = this;
  var arr = new Array();

  numbers.forEach(function (num) {
    arr.push(passed(num));
  });
  return arr
};

// Array.prototype.map = function(passed) {
//   numbers = this;
//   var arr = [];
//
//   numbers.myEach(function(passed));
//     arr.push(passed(this[i]))
//   }
//
//   return arr;
// };
//

// var timesTwo = function(num){
function timesTwo(num) {
  return num*3;
};

console.log([1, 2, 3, 4].map(timesTwo));

// ---------------------------------------------------------------------

Array.prototype.inject = function (passed) {
  numbers = this;
  var accumulator = numbers.shift();

  numbers.forEach(function(num) {
    accumulator = passed(accumulator, num);
  });
  return accumulator;
};

var multiply = function (total, num) {
  return total * num;
};

console.log([1, 2, 3, 4].inject(multiply));
