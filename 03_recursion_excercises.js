// ---------------------------------------------------------------------

function range(starting, ending) {
  if (ending <= starting) {
    return [];
  } else {
    return range(starting, ending-1).concat(ending);
  }
}


console.log(range(0, 10));

// ---------------------------------------------------------------------
