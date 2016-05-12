require_relative 'validation.rb'
class PassengerTrain < Train
  include Validation
  validate :id, :format, Train::ID_FORMAT
  validate :wagons, :type, Array

  protected

  def acceptable?(wagon)
    wagon.class == PassengerWagon
  end
end
