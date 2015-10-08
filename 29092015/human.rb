h1 = Human.new({age: 18, name: 'Vasya'})

class Human
  attr_accessor :age

  def initialize(args)
    args.each do |param|
      eval "@#{param} = @#{args[param]}"
    end
  end

  def age=()
    @age = age
  end

  def age
    @age
  end

  def name

  end

  def self.func

  end
end