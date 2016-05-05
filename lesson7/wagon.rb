class Wagon
  include Vendor
  attr_reader :units, :units_free

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
    true
  end
end
