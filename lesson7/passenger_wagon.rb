class PassengerWagon < Wagon
  attr_reader :seats, :seats_free

  def initialize(seats)
    @seats = seats
    @seats_free = @seats
    validate!
  end

  def take_seat
    raise 'No more seats' if @seats_free == 0
    @seats_free -= 1
  end

  def seats_taken
    @seats - @seats_free
  end

  protected

  def validate!
    unless @seats.is_a?(Integer) && @seats >= 0
      raise ArgumentError, 'Wrong seats argument'
    end
    true
  end
end
