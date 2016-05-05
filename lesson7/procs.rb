module Procs
  def show_wagon(train)
    proc do |wagon|
      print "Number: #{train.wagons.index(wagon)}, type: #{wagon.class}, "
        if train.class == PassengerTrain
          puts "free seats: #{wagon.units_free}, "\
               "taken seats: #{wagon.units_taken}"
        end
        if train.class == CargoTrain
          puts "free volume: #{wagon.units_free}, "\
               "taken volume: #{wagon.units_taken}"
        end
    end
  end

  def show_train
    proc do |train|
      puts "Id:#{train.id}, type:#{train.class}, wagons:#{train.wagons.count}"
    end
  end
end
