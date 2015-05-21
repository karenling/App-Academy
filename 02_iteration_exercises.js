// ---------------------------------------------------------------------


var bubbleSort = function(array) {

  var sorted = false;
  while (!sorted) {
    sorted = true;
    var i = 0
    while (i < array.length) {
      if (array[i] > array[i+1]) {
        first = array[i];
        second = array[i+1];
        array[i] = second;
        array[i+1] = first;
        sorted = false;
      }
      i++
    }
  }
  return array;
};

console.log(bubbleSort([9, 3, 4, 8, 2, 1, 5, 7, 6]));


// ---------------------------------------------------------------------
