class CargoTrain < Train
  protected

  def acceptable?(wagon)
    wagon.class == CargoWagon
  end
end
