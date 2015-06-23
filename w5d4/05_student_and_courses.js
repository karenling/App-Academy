"use strict";


function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function() {
  return (this.firstName + " " + this.lastName);
};

Student.prototype.hasConflict = function(potential_course) {
  var conflict = false;
  this.courses.forEach(function(course) {
    if (course.conflictsWith(potential_course)) {
      conflict = true;
    }
  })
  return conflict;
};

Student.prototype.enroll = function(course) {

  if (course.students.indexOf(this) !== -1) {
    console.log("Student is already enrolled.");
  };
  if (this.hasConflict(course)) {
    console.log("Conflicting course schedule");
  } else {
    this.courses.push(course);
    course.addStudent(this);
  };

};

Student.prototype.courseLoad = function() {
  var courseLoad = {};
  this.courses.forEach(function (course) {
    var dpt = course.department;
    courseLoad[dpt] = courseLoad[dpt] || 0;
    courseLoad[dpt] += course.numberOfCredits;
  });
  return courseLoad;
};

function Course(courseName, department, numberOfCredits, days, block) {
  this.courseName = courseName;
  this.department = department;
  this.numberOfCredits = numberOfCredits;
  this.students = [];
  this.days = days;
  this.block = block;
}

Course.prototype.addStudent = function(student) {
  this.students.push(student);
}

Course.prototype.conflictsWith = function (otherCourse) {
  var dayConflict = false;
  this.days.forEach(function (day) {
    otherCourse.days.forEach(function (day2) {
      if (day === day2) {
        dayConflict = true;
      }
    })
  })
  if (this.block === otherCourse.block && dayConflict) {
    return true;
  } else {
    return false;
  };
};

var karen = new Student("Karen", "Ling");
var jon = new Student("Jon", "B");
var course1 = new Course("Biology", "Science", 4, ["mon", "wed", "fri"], 3);
var course2 = new Course("Calculus", "Math", 4, ["wed"], 3);
var course3 = new Course("Psychology", "Science", 4, ["mon", "wed", "fri"], 5);
var course4 = new Course("Photography", "Art", 3, ["wed", "fri"], 5);


console.log(karen.name());

karen.enroll(course1);

// karen.enroll(course3);

console.log(karen.courses);
console.log(course1.students);
console.log(karen.courseLoad());

console.log(course3.conflictsWith(course4));
