require_relative 'validation.rb'
class PassengerWagon < Wagon
  include Validation

  UNITS_CLASS = Integer
  UNITS = :seats

  validate :units, :type, UNITS_CLASS

  def take
    raise 'No more seats' if @units_free == 0
    @units_free -= 1
  end
end
