class CargoTrain < Train
  def initialize(number, wagons)
    super
    @wagons = wagons if wagons.all? { |wagon| wagon.class == CargoWagon }
  end

  #используется извне
  def add_wagon(wagon)
    @wagons << wagon if wagon.class == CargoWagon
  end
end
