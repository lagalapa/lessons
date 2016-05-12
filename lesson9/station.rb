require_relative 'validation.rb'
class Station
  include Validation

  attr_reader :name, :trains

  def self.all
    ObjectSpace.garbage_collect
    ObjectSpace.each_object(self)
  end

  validate :name, :presence

  def initialize(name)
    @name = name
    @trains = []
    validate!
  end

  def each(&block)
    @trains.each { |train| yield train }
  end

  def add(train)
    unless train.class.ancestors.include?(Train) && train.valid?
      raise 'Not valid train'
    end
    @trains << train
    train.current_station = self
  end

  def send_train(train, station)
    station.add(train)
    @trains.delete(train)
  end

  # private
  #
  # def validate!
  #   raise ArgumentError, 'Name cannot be empty' if @name.empty?
  #   true
  # end
end
