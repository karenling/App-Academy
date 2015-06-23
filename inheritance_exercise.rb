require 'byebug'

class Employee

  attr_reader :salary, :employees

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    add_to_boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

  def add_to_boss
    @boss.employees << self if @boss # b/c ned doesn't have a boss
  end

  def inspect
    {:name => @name}.inspect

  end
end

class Manager < Employee
  attr_reader :employees, :name


  def initialize(name, title, salary, boss, employees = [])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    # calculate total salary of all sub-employees
    # total = 0

    queue = [self]
    list_of_employees = []

    until queue.empty?
      current = queue.shift
      next unless current.is_a?(Manager)
      list_of_employees += current.employees
      queue += current.employees
    end

    total = 0
    list_of_employees.each do |employee|
      total += employee.salary
    end

    total *= multiplier
  end



end

ned = Manager.new("Ned", "Founder", 1_000_000, nil)
darren = Manager.new("Darren", "TA Manager", 78_000, ned)
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new("David", "TA", 10_000, darren)

# p ned.b
# p darren.employees

# byebug
p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
