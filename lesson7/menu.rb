class Menu
  def initialize
    @stations = {}
    @trains   = {}
  end

  def run
    loop do
      puts
      puts '1) Make a station'
      puts '2) Make a train'
      puts '3) Add wagons to a train'
      puts '4) Remove wagons from train'
      puts '5) Add train to a station'
      puts '6) Show stations list'
      puts '7) Show trains on the station'
      puts '8) Show wagons of the train'
      puts '9) Take a seat or volume in a train'
      puts '0) Exit'
      print 'Make your choice: '
      choice = gets.to_i
      break if choice == 0
      case choice
      when 1
        make_station
      when 2
        make_train
      when 3
        add_wagons
      when 4
        remove_wagons
      when 5
        add_train
      when 6
        @stations.each_key { |name| puts name }
      when 7
        show_trains
      when 8
        show_wagons
      when 9
        take
      end
    end
  end

  private

  def make_station
    print 'Station name: '
    name = gets.chomp
    @stations[name] = Station.new(name)
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def make_train
    print 'Train id: '
    id = gets.chomp
    print 'Wagons quantity '
    quantity = gets.to_i
    print 'Type (passenger/cargo): '
    type = gets.chomp
    case type
    when 'passenger'
      print 'Seats amount: '
      seats = gets.to_i
      train = PassengerTrain.new(id, wagons(type, quantity, seats))
    when 'cargo'
      print 'Volume amount: '
      volume = gets.to_f
      train = CargoTrain.new(id, wagons(type, quantity, volume))
    else
      raise ArgumentError, 'Wrong train type'
    end
    @trains[id] = train
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def wagons(type, quantity, units)
    wagon_class = PassengerWagon if type == 'passenger'
    wagon_class = CargoWagon if type == 'cargo'
    [].fill(0...quantity) { wagon_class.new(units) }
  end

  def add_wagons
    print 'Train id: '
    id = gets.chomp
    raise 'Train not found' if @trains[id].nil?
    print 'Wagons quantity: '
    quantity = gets.to_i
    train_class = @trains[id].class
    if train_class == PassengerTrain
      print 'Seats amount: '
      units = gets.to_i
      wagon_class = PassengerWagon
    end
    if train_class == CargoTrain
      print 'Volume amount: '
      units = gets.to_f
      wagon_class = CargoWagon
    end
    quantity.times { |_i| @trains[id].add_wagon(wagon_class.new(units)) }
  rescue RuntimeError => e
    puts e.message
  end

  def remove_wagons
    print 'Train id: '
    id = gets.chomp
    raise 'Train not found' if @trains[id].nil?
    print 'Wagons number: '
    quantity = gets.to_i
    @trains[id].remove_wagons(quantity)
  rescue RuntimeError => e
    puts e.message
  end

  def add_train
    print 'Train id: '
    id = gets.chomp
    raise 'Train not found' if @trains[id].nil?
    print 'Station name: '
    name = gets.chomp
    raise 'Station not found' if @stations[name].nil?
    @stations[name].add(@trains[id])
  rescue RuntimeError => e
    puts e.message
  end

  def show_trains
    print 'Station name: '
    name = gets.chomp
    station = @stations[name]
    raise 'Station not found' if station.nil?
    station.each &show_train
  rescue RuntimeError => e
    puts e.message
  end

  def show_wagons
    print 'Train id: '
    id = gets.chomp
    train = @trains[id]
    raise 'Train not found' if train.nil?
    train.each &show_wagon(train)
  rescue RuntimeError => e
    puts e.message
  end

  def take
    print 'Train id: '
    id = gets.chomp
    train = @trains[id]
    raise 'Train not found' if train.nil?
    print 'Wagon number: '
    index = gets.to_i
    raise 'Wagon not found' if train.wagons[index].nil?
    train.wagons[index].take_seat if train.class == PassengerTrain
    if train.class == CargoTrain
      print 'Volume: '
      volume = gets.to_f
      train.wagons[index].take_volume(volume)
    end
  rescue RuntimeError => e
    puts e.message
  rescue ArgumentError => e
    puts e.message
  end
end
