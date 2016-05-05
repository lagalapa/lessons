module Procs
  def show_wagon(train)
    proc do |wagon|
      print "Number: #{train.wagons.index(wagon)}, type: #{wagon.class}, "
        if train.class == PassengerTrain
          puts "free seats: #{wagon.seats_free}, "\
               "taken seats: #{wagon.seats_taken}"
        end
        if train.class == CargoTrain
          puts "free volume: #{wagon.volume_free}, "\
               "taken volume: #{wagon.volume_taken}"
        end
    end
  end

  def show_train
    proc do |train|
      puts "Id:#{train.id}, type:#{train.class}, wagons:#{train.wagons.count}"
    end
  end
end
