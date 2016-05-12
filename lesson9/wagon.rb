require_relative 'validation.rb'
class Wagon
  include Vendor
  include Validation
  attr_reader :units, :units_free

  UNITS_CLASS = Numeric
  UNITS = :units

  validate :units, :type, UNITS_CLASS

  def initialize(units)
    @units = units
    @units_free = @units
    validate!
  end

  def units_taken
    @units - @units_free
  end

  # protected

  # def validate!
  #   units_class = self.class::UNITS_CLASS
  #   unless @units.is_a?(units_class) && @units >= 0
  #     raise "Expected #{units_class} argument"
  #   end
  #   true
  # end
end
