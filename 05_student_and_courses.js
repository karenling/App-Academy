function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}

Student.prototype.name = function() {
  return (this.firstName + " " + this.lastName);
};

Student.prototype.courses = function() {

};

Student.prototype.enroll = function() {

};

Student.prototype.course_load = function() {

};

function Course(courseName, department, numberOfCredits) {
  this.courseName = courseName;
  this.department = department;
  this.numberOfCredits = numberOfCredits;
}

Course.prototype.students = function() {

};

Course.prototype.add_student = function(student) {

}

var karen = new Student("Karen", "Ling");

var course1 = new Course("Biology", "Science", 4);
var course2 = new Course("Calculus", "Math", 4);
var course3 = new Course("Psychology", "Science", 4);
var course4 = new Course("Photography", "Art", 3)


console.log(karen.name());
