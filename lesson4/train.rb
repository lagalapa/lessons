class Train
  attr_accessor :speed, :current_station
  attr_reader   :number, :wagons
  attr_writer   :route
  
  def initialize(number, wagons_number)
    @number = number
    @speed = 0
    add_wagons(wagons_number)
  end

  #используется извне класса
  def add_wagons(wagons_number)
    @wagons = [] if wagons.nil?
    @wagons.fill(0...wagons_number) { |i| new_wagon }
  end
  
  #используется извне класса
  def remove_wagons(wagons_number)
    @wagons.pop(wagons_number)
  end
  
  #используется извне классе
  def stop
    @speed = 0
  end
  
  #может использоваться извне класса, тут нечего скрывать
  def next_station
    if @route && @current_station != @route.stations.last
      if @route.stations.include?(@current_station)
        @next_station = @route.stations[current_station_index + 1]
      else
        @next_station = @route.stations.first
      end
    end
  end
  
  #может использоваться извне класса, нечего скрывать
  def previous_station
    if current_station_index && current_station_index > 0
      @previous_station = @route.stations[current_station_index - 1]
    end
  end
  
  #используется извне класса
  def move
    @current_station.send(self, @next_station) if next_station
  end
  
  #используется извне класса
  def show_near_stations
    puts "Previous station: #{@previous_station.name if previous_station}"
    puts "Current station: #{@current_station.name if @current_station}"
    puts "Next station: #{@next_station.name if next_station}"
  end
  
  #у нас есть подклассы поэтому используем protected
  protected
  
  #вспомогательный метод, не должен быть изпользован извне
  def new_wagon
    Wagon.new
  end
  
  #тоже вспомогательный, не нужен извне
  def current_station_index
    if @route && @route.stations.include?(@current_station)
        @route.stations.find_index(@current_station)
    end
  end
end
