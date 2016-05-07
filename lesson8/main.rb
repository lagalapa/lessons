require_relative 'files.rb'
include Procs

stations = []
s1 = Station.new('Station1')
s2 = Station.new('Station2')
s3 = Station.new('Station3')
stations << s1 << s2 << s3
pw1 = []
pw2 = []
pw3 = []
10.times { pw1 << PassengerWagon.new(15) }
20.times { pw2 << PassengerWagon.new(35) }
16.times { pw3 << PassengerWagon.new(20) }
pt1 = PassengerTrain.new('p1000', pw1)
pt2 = PassengerTrain.new('p2000', pw2)
pt3 = PassengerTrain.new('p3000', pw3)
cw1 = []
cw2 = []
cw3 = []
15.times { cw1 << CargoWagon.new(500) }
25.times { cw2 << CargoWagon.new(101.8) }
10.times { cw3 << CargoWagon.new(0.800) }
ct1 = CargoTrain.new('c1000', cw1)
ct2 = CargoTrain.new('c2000', cw2)
ct3 = CargoTrain.new('c3000', cw3)
s1.add(pt1)
s1.add(ct1)
s2.add(pt2)
s2.add(pt3)
s2.add(ct2)
s3.add(ct3)

stations.each do |station|
  station.each do |train|
    show_train.call(train)
    train.each(&show_wagon(train))
  end
end
