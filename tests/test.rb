require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

train = PassengerTrain.new(228, 5)
p train.wagons
train.add_wagons(3)
p train.wagons
train.remove_wagons(2)
p train.wagons
train.remove_wagons(22)
p train.wagons
train.add_wagons(2)
p train.wagons
