class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  #используется извне
  def add(station)
    @stations.insert(-2, station)
  end

  #используется извне
  def remove(station)
    @stations.delete(station)
  end

  #используется извне
  def show
    @stations.each { |station| puts station.name }
  end
end
