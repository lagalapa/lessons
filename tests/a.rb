class Animal
  attr_accessor :name
  
  def initialize
    self.name = 'Murzik'
  end
end

pet = Animal.new
puts pet.name
