class Person

  def names
    @names
  end

  def names=(name)
    @names = name
  end

  def initialize
    @names = %w[ jerry jessica john]
  end

  def say_name
    puts names[0]
  end
end

person = Person.new
person.say_name
