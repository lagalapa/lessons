class Route
  def initialize(first, last)
    @stations = []
    @stations << first << last
  end
  
  attr_reader :stations
  
  def add(station)
    @stations.insert(-2, station)
  end
  
  def remove(station)
    @stations.delete(station)
  end
  
  def show
    @stations.each { |station| puts station.name }
  end
end