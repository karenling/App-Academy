"use strict";

function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  return ("Everyone loves " + this.name + "!");
};

Cat.prototype.meow = function () {
  return ("Meow!");
};
var gizmo = new Cat("Gizmo", "Ned");
var breakfast = new Cat("Breakfast", "CJ");

// console.log(gizmo.cuteStatement());
// console.log(breakfast.cuteStatement());
// console.log(gizmo.meow());
// console.log(breakfast.meow());

gizmo['meow'] = function () {
  return ("Meowwwww!");
};

console.log(gizmo['meow']());
console.log(breakfast['meow']());
