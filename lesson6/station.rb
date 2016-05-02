class Station
  attr_reader :name, :trains

  def self.all
    ObjectSpace.each_object(self)
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

  def add(train)
    unless train.class.ancestors.include?(Train) && train.valid?
      raise ArgumentError, 'Not valid train'
    end
    @trains << train
    train.current_station = self
  rescue ArgumentError => e
    puts e.message
  end

  def show(type = nil)
    if type
      trains = @trains.select { |train| train.class.to_s == type }
    else
      trains = @trains
    end

    trains.each do |train|
      puts train.id
    end
  end

  def send(train, station)
    station.add(train)
    @trains.delete(train)
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise ArgumentError, 'Name cannot be empty' if @name.empty?
    true
  end
end
