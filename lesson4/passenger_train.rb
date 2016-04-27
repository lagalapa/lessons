class PassengerTrain < Train
  #используется извне
  def add_wagons(wagons_number)
    wagons_number.times { |_i| @wagons << PassengerWagon.new }
  end
end
