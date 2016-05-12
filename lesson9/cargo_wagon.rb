require_relative 'validation.rb'
class CargoWagon < Wagon
  include Validation

  UNITS = :volume

  validate :units, :type, Wagon::UNITS_CLASS

  def take(volume)
    raise 'Not enough free volume' if @units_free - volume < 0
    @units_free -= volume
  end
end
