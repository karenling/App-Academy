var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function (sum, numsLeft, completionCallback) {

  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  } else {
    reader.question("Give me number", function (answer) {
      var number = parseInt(answer);
      sum += number;
      console.log("Sum is: " + sum);
      numsLeft--;
      addNumbers(sum, numsLeft, completionCallback);
    });
  }
}

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});






// var readline = require('readline');
// var reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });
//
// var addNumbers = function(sum, numsLeft, completionCallback){
//   if (numsLeft > 0)
//   {
//     reader.question("Give me number", function(answer){
//       var number = parseInt(answer);
//       sum += number;
//       console.log("Current sum: " + sum);
//     });
//     numsLeft--;
//
//
//
//   }
//   else{
//     reader.close();
//     completionCallback(sum);
//   }
// }
//
// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });
