// ---------------------------------------------------------------------
"use strict";

function range(starting, ending) {
  if (ending <= starting) {
    return [];
  } else {
    return range(starting, ending-1).concat(ending);
  }
}


// console.log(range(0, 10));

// ---------------------------------------------------------------------

function sum_of_array(array) {
  if (array.length === 0) {
    return 0
  } else {
    var last_num = array.shift();

    return last_num + sum_of_array(array); // why does order matter here?
  }
}

console.log(sum_of_array([1, 2, 3]));

// ---------------------------------------------------------------------

function exp1(base, power) {
 if (power === 0) {
   return 1
 } else {
   return base * exp1(base, power-1)
 }
}

// console.log(exp1(2, 3));

function exp2(b, n) {
  if (n === 0 ) {
    return 1
  } else {
    if (n % 2 === 0) {
      return exp2(b, n / 2) * exp2(b, n / 2);
    } else {
      return b * (exp2(b, (n - 1) / 2) * exp2(b, (n - 1) / 2));
    }
  }
}

// console.log(exp2(2, 3));


// ---------------------------------------------------------------------

// fibonacci recursion
function fibonacci(n) {
  if (n === 0) {
    return [];
  } else if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0, 1];
  } else {
    var prevFibs = fibonacci(n-1);
    var arrayLength = prevFibs.length;
    nextNum = (prevFibs[arrayLength-1] + prevFibs[arrayLength-2]);
    prevFibs.push(nextNum);
    return prevFibs;
  }

}
// console.log(fibonacci(7));


function fibonacci_iterate(n) {
  var sequence = [0, 1];
  while (sequence.length < n) {
    sequenceLength = sequence.length
    sequence.push(sequence[sequenceLength-2] + sequence[sequenceLength-1])
  }

  return sequence

}

// console.log(fibonacci_iterate(7));

// ---------------------------------------------------------------------


function bsearch(array, target) {
  if (array.length === 0) {
    return null;
  }
  var middle = Math.floor(array.length/2);
  var left = array.slice(0, middle);
  var right = array.slice(middle+1, array.length);

  if (target === array[middle]) {
    return middle;
  } else if (target < array[middle]) {
    return bsearch(left, target)
  } else if (target > array[middle]) {
    var result = bsearch(right, target);
    if (result === null ) {
      return null;
    } else {
      return middle + 1 + result;
    }
  }
}

console.log(bsearch([1, 2,  3], 1)); //# => 0
console.log(bsearch([2, 3, 4, 5], 3));// # => 1
console.log(bsearch([2, 4, 6, 8, 10], 6));// # => 2
console.log(bsearch([1, 3, 4, 5, 9], 5)); //# => 3
console.log(bsearch([1, 2, 3, 4, 5, 6], 6));// # => 5
console.log(bsearch([1, 2, 3, 4, 5, 6], 0));// # => nil
console.log(bsearch([1, 2, 3, 4, 5, 7], 6));// # => nil
