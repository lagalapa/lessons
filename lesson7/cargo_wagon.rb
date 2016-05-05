class CargoWagon < Wagon
  attr_reader :volume, :volume_free

  def initialize(volume)
    @volume = volume
    @volume_free = @volume
    validate!
  end

  def take_volume(volume)
    raise ArgumentError, 'Not enough free volume' if @volume_free - volume < 0
    @volume_free -= volume
  end

  def volume_taken
    @volume - @volume_free
  end

  protected

  def validate!
    unless @volume.is_a?(Numeric) && @volume >= 0
      raise ArgumentError, 'Wrong volume argument'
    end
    true
  end
end
