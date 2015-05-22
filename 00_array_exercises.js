// ----------------------------------------------------------------------
"use strict";

var my_transpose = function(array) {
  var transformed = [];

  for (el in array) {
    var row = [];
    for (el2 in array) {
      row.push(array[el2][el]);
    }
    transformed.push(row);
  }

  console.log(JSON.stringify(transformed));
}

my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]);

//----------------------------------------------------------------------

Array.prototype.myUniq = function() {
  var unique_numbers = [];

  this.forEach(function(num) {
    if (unique_numbers.indexOf(num) === -1) {
      unique_numbers.push(num);
    }
  });

  return unique_numbers;
}

console.log(JSON.stringify([1, 2, 1, 3, 3].myUniq()));

//----------------------------------------------------------------------

Array.prototype.twoSum = function () {
  var pairs = [];
  var i = 0;
  while (i < this.length) {
    var j = 0
    while (j < this.length) {

      if ((i < j) && (this[i] + this[j] == 0)) {
        console.log([i, j]);
        pairs.push([i, j]);
      };

      j++
    }
    i++
  }

  return pairs;

}

console.log(JSON.stringify([-1, 0, 2, -2, 1].twoSum()));

//----------------------------------------------------------------------

var twoSum = function(numbers) {
  var pairs = [];
  var i = 0;
  while (i < numbers.length) {
    var j = 0;
    while (j < numbers.length) {

      if ((i < j) && (numbers[i] + numbers[j] == 0)) {
        console.log([i, j]);
        pairs.push([i, j]);
      };

      j++
    }
    i++
  }

  return pairs;
}

// the non-monkey patch call
// console.log(JSON.stringify(twoSum([-1, 0, 2, -2, 1])));

Array.prototype.twoSum = function () { return twoSum(this) };

console.log(JSON.stringify([-1, 0, 2, -2, 1].twoSum())); // using the above line and monkey-patching

//----------------------------------------------------------------------
