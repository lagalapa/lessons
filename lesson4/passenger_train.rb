class PassengerTrain < Train
  def initialize(number, wagons)
    super
    @wagons = wagons if wagons.all? { |wagon| wagon.class == PassengerWagon }
  end

  #используется извне
  def add_wagon(wagon)
    @wagons << wagon if wagon.class == PassengerWagon
  end
end
