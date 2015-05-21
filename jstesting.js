
var my_uniq = function(numbers) {
  var unique_numbers = []

  numbers.forEach(function(num) {
    if (unique_numbers.indexOf(num) == -1) {
      unique_numbers.push(num);
    }
  });

  return unique_numbers
}

console.log(my_uniq([1, 2, 1, 3, 3]));
