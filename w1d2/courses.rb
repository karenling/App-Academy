class Student
  attr_reader :courses

  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
    @course_load = Hash.new(0)
  end

  def name
    @first + " " + @last
  end

  def courses
     @courses
  end

  def has_conflict?(course)
    student_conflict = false
    @courses.each do |enrolled_course|
      if course.conflicts_with?(enrolled_course)
        student_conflict = true
      end
    end
    return student_conflict
  end




  def enroll(course)
    #takes a course object adds it to the studens list of courses and updates the couress list
    raise "Must add a course!" unless course.is_a?(Course)



    if has_conflict?(course)
      raise "Conflicting schedule"
    elsif @courses.include?(course)
      raise "Already enrolled"
    else
      @courses << course
      course.add_student(self) # add_student relies on Student#enroll
      @course_load[course.department] += course.credits
    end
  end

  def course_load
    @course_load
  end
end

class Course
  attr_accessor :department, :credits, :days, :time_block
  def initialize(course_name, department, credits, time_block, days)
    @course_name = course_name
    @department = department
    @credits = credits
    @time_block = time_block
    @days = days
    @students = []
  end

  def students
    @students
  end

  def add_student(student)
    @students << student
  end

  def conflicts_with?(course)
    return true if self.days == course.days && self.time_block == course.time_block
    return false
  end

end

#if __FILE__ == $PROGRAM_NAME
  john = Student.new("John", "Deer")
  jane = Student.new("Jane", "Doe")

  english = Course.new("English 101", "Lingustics", 10, "#1", [:mon, :wed, :fri])
  biology = Course.new("Biology 101", "Science", 10, "#2", [:tue, :thur])
  calculus = Course.new("Calculus 101", "Math", 5, "#3", [:mon, :wed, :fri])
  chemistry = Course.new("Chemisty 101", "Science", 10, "#2", [:tue, :thur])
  john.enroll(english)
  john.courses
  #p first.enroll(english)

p  jane.enroll(biology)
p  jane.enroll(chemistry)

#end
