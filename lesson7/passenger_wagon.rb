class PassengerWagon < Wagon
  def take
    raise ArgumentError, 'No more seats' if @units_free == 0
    @units_free -= 1
  end

  protected

  def validate!
    unless @units.is_a?(Integer) && @units >= 0
      raise ArgumentError, 'Wrong seats argument'
    end
    true
  end
end
