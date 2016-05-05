class CargoWagon < Wagon
  def take(volume)
    raise ArgumentError, 'Not enough free volume' if @units_free - volume < 0
    @units_free -= volume
  end

  protected

  def validate!
    unless @units.is_a?(Numeric) && @units >= 0
      raise ArgumentError, 'Wrong volume argument'
    end
    true
  end
end
