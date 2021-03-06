class CargoWagon < Wagon
  UNITS = :volume

  def take(volume)
    raise ArgumentError, 'Not enough free volume' if @units_free - volume < 0
    @units_free -= volume
  end
end
