class Menu
  def initialize
    @stations = {}
    @trains   = {}
  end

  def run
    menu = menu_items.zip(menu_actions).to_h

    loop do
      menu_items.each_with_index { |item, index| puts "\e[32m#{index}) #{item}\e[0m" }
      print 'Make your choice: '
      choice = gets.to_i
      key = menu_items[choice]
      menu[key].call
    end
  end

  private

  def menu_items
    ['Make a station', 'Make a train', 'Add wagons to a train',\
     'Remove wagons from train', 'Add train to a station',\
     'Show stations list', 'Show trains on the station',\
     'Show wagons of the train', 'Take a seat or volume in a train', 'Exit']
  end

  def menu_actions
    [proc { make_station }, proc { make_train }, proc { add_wagons },\
     proc { remove_wagons }, proc { add_train }, proc { show_stations },\
     proc { show_trains }, proc { show_wagons }, proc { take },\
     proc { raise StopIteration }]
  end

  def make_station
    name = station_name
    @stations[name] = Station.new(name)
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def show_stations
    @stations.each_key { |name| puts name }
  end

  def make_train
    id = train_id
    quantity = wagons_quantity
    print 'Type (passenger/cargo): '
    type = gets.chomp
    case type
    when 'passenger'
      seats = seats_amount
      train = PassengerTrain.new(id, wagons(type, quantity, seats))
    when 'cargo'
      volume = volume_amount
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
    id = train_id
    raise ArgumentError, 'Train not found' if @trains[id].nil?
    quantity = wagons_quantity
    train_class = @trains[id].class
    if train_class == PassengerTrain
      units = seats_amount
      wagon_class = PassengerWagon
    end
    if train_class == CargoTrain
      units = volume_amount
      wagon_class = CargoWagon
    end
    quantity.times { |_i| @trains[id].add_wagon(wagon_class.new(units)) }
  rescue ArgumentError => e
    puts e.message
  end

  def remove_wagons
    id = train_id
    raise 'Train not found' if @trains[id].nil?
    quantity = wagons_quantity
    @trains[id].remove_wagons(quantity)
  rescue RuntimeError => e
    puts e.message
  end

  def add_train
    id = train_id
    raise 'Train not found' if @trains[id].nil?
    name = station_name
    raise 'Station not found' if @stations[name].nil?
    @stations[name].add(@trains[id])
  rescue RuntimeError => e
    puts e.message
  end

  def show_trains
    name = station_name
    station = @stations[name]
    raise 'Station not found' if station.nil?
    station.each(&show_train)
  rescue RuntimeError => e
    puts e.message
  end

  def show_wagons
    id = train_id
    train = @trains[id]
    raise 'Train not found' if train.nil?
    train.each(&show_wagon(train))
  rescue RuntimeError => e
    puts e.message
  end

  def take
    train = @trains[train_id]
    raise ArgumentError, 'Train not found' if train.nil?
    print 'Wagon number: '
    index = gets.to_i
    raise ArgumentError, 'Wagon not found' if train.wagons[index].nil?
    train.wagons[index].take if train.class == PassengerTrain
    if train.class == CargoTrain
      volume = volume_amount
      train.wagons[index].take(volume)
    end
  rescue ArgumentError => e
    puts e.message
  end

  def train_id
    print 'Train id: '
    gets.chomp
  end

  def station_name
    print 'Station name: '
    gets.chomp
  end

  def wagons_quantity
    print 'Wagons quantity: '
    gets.to_i
  end

  def seats_amount
    print 'Seats amount: '
    gets.to_i
  end

  def volume_amount
    print 'Volume amount: '
    gets.to_f
  end
end
