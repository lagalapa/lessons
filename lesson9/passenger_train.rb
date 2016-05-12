require_relative 'validation.rb'
class PassengerTrain < Train
  include Validation

  protected

  def acceptable?(wagon)
    wagon.class == PassengerWagon
  end
end
