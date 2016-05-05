class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    validate!
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def remove(station)
    @stations.delete(station)
  end

  def show
    @stations.each { |station| puts station.name }
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    if @stations.any? { |station| station.class != Station }
      raise ArgumentError, 'Route must contain Station objects only'
    end
    true
  end
end
