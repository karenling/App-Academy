function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function() {
  return (this.firstName + " " + this.lastName);
};


Student.prototype.enroll = function(course) {
  this.courses.push(course);
  if (course.students.indexOf(this)) {
    course.addStudent(this);
  }
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

function Course(courseName, department, numberOfCredits) {
  this.courseName = courseName;
  this.department = department;
  this.numberOfCredits = numberOfCredits;
  this.students = [];
}

Course.prototype.addStudent = function(student) {
  this.students.push(student);

}

var karen = new Student("Karen", "Ling");
var jon = new Student("Jon", "B");
var course1 = new Course("Biology", "Science", 4);
var course2 = new Course("Calculus", "Math", 4);
var course3 = new Course("Psychology", "Science", 4);
var course4 = new Course("Photography", "Art", 3)


console.log(karen.name());

karen.enroll(course1);
karen.enroll(course2);
karen.enroll(course3);

console.log(karen.courses);
console.log(course1.students);
console.log(karen.courseLoad());
