class Station
  def initialize(name)
    @name = name
    @trains = []
  end
  
  attr_reader :name, :trains
  
  def add(train)
    @trains << train
    train.current_station = self
  end
  
  def show(type = 'all')
    if type == 'all'
      trains = @trains
    else 
      trains = @trains.select { |train| train.type == type }
    end
    
    trains.each do |train|
      puts train.number
    end
  end
  
  def send(train, station)
    @trains.delete(train)
    station.add(train)
  end
end