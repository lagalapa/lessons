class Train
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end
  
  attr_accessor :speed, :current_station
  attr_reader   :number, :type, :wagons
  attr_writer   :route
  
  def stop
    @speed = 0
  end
  
  def add
    @wagons += 1 if @speed == 0
  end
  
  def remove
    @wagons -= 1 if @speed == 0
  end
  
  def current_station_index
    if @route && @route.stations.include?(@current_station)
        @route.stations.find_index(@current_station)
    end
  end
  
  def next_station
    if @route && @current_station != @route.stations.last
      if @route.stations.include?(@current_station)
        @next_station = @route.stations[current_station_index + 1]
      else
        @next_station = @route.stations.first
      end
    end
  end
  
  def previous_station
    if current_station_index && current_station_index > 0
      @previous_station = @route.stations[current_station_index - 1]
    end
  end
  
  def next_and_previous_stations
    if @route != nil && (@current_station != @route.stations.last)
      if @route.stations.include?(@current_station)
        current_station_index = @route.stations.find_index(@current_station)
        @next_station = @route.stations[current_station_index + 1]
        if current_station_index > 0 
          @previous_station = @route.stations[current_station_index - 1]
        end
      else
        @next_station = @route.stations.first
      end
    end
  end

  def move
    @current_station.send(self, @next_station) if next_station
  end
  
  def show_near
    previous_s = previous_station ? @previous_station.name : "None"
    current_s = @current_station ? @current_station.name : "None"
    next_s = next_station ? @next_station.name : "None"
    puts "Previous station: #{previous_s}"
    puts "Current station: #{current_s}"
    puts "Next station: #{next_s}"
  end
end
