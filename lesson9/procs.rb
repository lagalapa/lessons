module Procs
  def show_wagon(train)
    proc do |wagon|
      units = wagon.class::UNITS
      print "Number: #{train.wagons.index(wagon)}, type: #{wagon.class}, "
      puts "free #{units}: #{wagon.units_free}, taken #{units}: #{wagon.units_taken}"
    end
  end

  def show_train
    proc do |train|
      puts "Id:#{train.id}, type:#{train.class}, wagons:#{train.wagons.count}"
    end
  end
end
