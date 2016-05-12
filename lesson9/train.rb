require_relative 'instance_counter.rb'
require_relative 'validation.rb'
class Train
  include Vendor
  include InstanceCounter
  include Validation

  attr_accessor :speed, :current_station
  attr_reader   :id, :wagons
  attr_writer   :route

  def self.find(id)
    ObjectSpace.garbage_collect
    ObjectSpace.each_object(self).find { |train| train.id == id }
  end

  ID_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  validate :id, :format, ID_FORMAT
  validate :wagons, :type, Array

  def initialize(id, wagons)
    @id = id
    @speed = 0
    @wagons = wagons
    validate!
    register_instance
  end

  def each(&block)
    @wagons.each { |wagon| yield wagon }
  end

  def add_wagon(wagon)
    raise 'Wrong wagon type' unless acceptable?(wagon)
    @wagons << wagon
  end

  def remove_wagons(quantity)
    @wagons.pop(quantity)
  end

  def stop
    @speed = 0
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

  def move
    @current_station.send_train(self, @next_station) if next_station
  end

  def show_near_stations
    puts "Previous station: #{@previous_station.name if previous_station}"
    puts "Current station: #{@current_station.name if @current_station}"
    puts "Next station: #{@next_station.name if next_station}"
  end

  protected

  def acceptable?(wagon)
    wagon.class.ancestors.include? Wagon
  end

  def current_station_index
    if @route && @route.stations.include?(@current_station)
      @route.stations.find_index(@current_station)
    end
  end

  # def validate!
  #   if @id !~ ID_FORMAT
  #     raise ArgumentError, 'Id format must be ^[a-z\d]{3}-?[a-z\d]{2}$'
  #   end
  #   unless (@wagons.class == Array) && (@wagons.all? { |wagon| acceptable?(wagon) })
  #     raise ArgumentError, 'Wrong wagons type'
  #   end
  #   true
  # end
end
