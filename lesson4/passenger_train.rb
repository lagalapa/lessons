class PassengerTrain < Train
  def add_wagon(wagon)
    @wagons << wagon if wagon.class == PassengerWagon
  end

  protected

  def set_wagons(wagons)
    wagons.all? { |wagon| wagon.class == PassengerWagon } ? wagons : []
  end
end
