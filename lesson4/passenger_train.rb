class PassengerTrain < Train
  protected

  def acceptable?(wagon)
    wagon.class == PassengerWagon
  end
end
