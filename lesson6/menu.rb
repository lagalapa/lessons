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
      train = PassengerTrain.new(id, wagons(type, quantity))
    when 'cargo'
      train = CargoTrain.new(id, wagons(type, quantity))
    else
      raise ArgumentError, 'Wrong train type'
    end
    @trains[id] = train
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def wagons(type, quantity)
    wagon_class = PassengerWagon if type == 'passenger'
    wagon_class = CargoWagon if type == 'cargo'
    [].fill(0...quantity) { |_i| wagon_class.new }
  end

  def add_wagons
    print 'Train id: '
    id = gets.chomp
    raise 'Train not found' if @trains[id].nil?
    print 'Wagons quantity: '
    quantity = gets.to_i
    wagon_class = PassengerWagon if @trains[id].class == PassengerTrain
    wagon_class = CargoWagon if @trains[id].class == CargoTrain
    quantity.times { |_i| @trains[id].add_wagon(wagon_class.new) }
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
    raise 'Station not found' if @stations[name].nil?
    @stations[name].show
  rescue RuntimeError => e
    puts e.message
  end
end
