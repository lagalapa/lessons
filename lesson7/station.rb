class Station
  attr_reader :name, :trains

  def self.all
    ObjectSpace.garbage_collect
    ObjectSpace.each_object(self)
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

  def each(&block)
    @trains.each { |train| yield(train) }
  end

  def add(train)
    unless train.class.ancestors.include?(Train) && train.valid?
      raise ArgumentError, 'Not valid train'
    end
    @trains << train
    train.current_station = self
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
