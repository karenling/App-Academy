// ---------------------------------------------------------------------

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
    last_num = array.shift();
    return last_num + sum_of_array(array); // why does order matter here?
  }
}

console.log(sum_of_array([1, 2, 3]));
