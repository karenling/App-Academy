

var substrings = function(string) {
  all_substrings = new Array();
  var i = 0;
  while (i < string.length) {
    var n = 1;
    while (n < string.length) {
      console.log(string.substring(i,n));
      all_substrings.push(string.substring(i,n));
      n++;
    }
    i++;
  }
  return all_substrings
};


// console.log(substrings("cat"));
// ---------------------------------------------------------------------

function bubbleSort(array) {
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
}

// console.log(bubbleSort([9, 3, 4, 8, 2, 1, 5, 7, 6]));


// ---------------------------------------------------------------------
