class CargoTrain < Train
  #используется извне
  def add_wagons(wagons_number)
    wagons_number.times { |_i| @wagons << CargoWagon.new }
  end
end
