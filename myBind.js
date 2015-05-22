// Write your own myBind(context) method. Add it to Function.prototype.
// You'll want to:
// Capture this (which is the function to bind) in a variable named fn.
// Define and return an anonymous function.
// The anonymous function captures fn and context.
// In the anonymous function, call Function#apply on fn, passing the context.
// Assume the method you're binding doesn't take any arguments; we'll see
// tomorrow how to use the special arguments variable to fix this.
"use strict";

Function.prototype.myBind = function (context) {
  var fn = this;

  return (function () {
    fn.apply(context);
  });
};



var Cat = function (name, color) {
  this.name = name;
  this.color = color;
  this.meow = function() {
    console.log(this.name + " says meowww!");
  }
};

var gizmo = new Cat("Gizmo", "gray");

var gizmoMeow = gizmo.meow.myBind(gizmo);

gizmoMeow();
