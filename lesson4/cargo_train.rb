class CargoTrain < Train
  def add_wagon(wagon)
    @wagons << wagon if wagon.class == CargoWagon
  end

  protected

  def set_wagons(wagons)
    wagons.all? { |wagon| wagon.class == CargoWagon } ? wagons : []
  end
end
