require_relative 'validation.rb'
class CargoTrain < Train
  include Validation

  protected

  def acceptable?(wagon)
    wagon.class == CargoWagon
  end
end
