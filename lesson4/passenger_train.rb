class PassengerTrain < Train
    
  #переопределяем new_wagon
  #та же область что и в родительском классе
  protected
  
  #вспомогательный метод, не нужен извне
  def new_wagon
    PassengerWagon.new
  end
end