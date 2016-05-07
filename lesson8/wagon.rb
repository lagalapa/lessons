class Wagon
  include Vendor
  attr_reader :units, :units_free

  UNITS_CLASS = Numeric
  UNITS = :units

  def initialize(units)
    @units = units
    @units_free = @units
    validate!
  end

  def units_taken
    @units - @units_free
  end

  protected

  def validate!
    units_class = self.class::UNITS_CLASS
    unless @units.is_a?(units_class) && @units >= 0
      raise ArgumentError, "Expected #{units_class} argument"
    end
    true
  end
end
