class Station
  attr_reader :name, :trains

  def self.all
    ObjectSpace.each_object(self) { |station| puts station.name }
  end

  def initialize(name)
    @name = name
    @trains = []
  end

  # используется извне
  def add(train)
    @trains << train
    train.current_station = self
  end

  # используется извне
  def show(type = nil)
    if type
      trains = @trains.select { |train| train.class.to_s == type }
    else
      trains = @trains
    end

    trains.each do |train|
      puts train.number
    end
  end

  # используется извне
  def send(train, station)
    @trains.delete(train)
    station.add(train)
  end
end
