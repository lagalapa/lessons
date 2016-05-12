class PassengerWagon < Wagon
  UNITS_CLASS = Integer
  UNITS = :seats

  def take
    raise 'No more seats' if @units_free == 0
    @units_free -= 1
  end
end
