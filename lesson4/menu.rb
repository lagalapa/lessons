class Menu
  def initialize
    @stations = {}
    @trains   = {}
  end

  def run
    loop do
      puts
      puts '1) Make s station'
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
  end

  def make_train
    print 'Train number: '
    number = gets.chomp
    print 'Wagons number '
    wagons_number = gets.to_i
    print 'Type (passenger/cargo): '
    type = gets.chomp
    train = PassengerTrain.new(number, wagons_number) if type == 'passenger'
    train = CargoTrain.new(number, wagons_number) if type == 'cargo'
    @trains[number] = train
  end

  def add_wagons
    print 'Train number: '
    number = gets.chomp
    print 'Wagons number: '
    wagons_number = gets.to_i
    if @trains[number]
      @trains[number].add_wagons(wagons_number)
    else
      puts 'Train does not exist'
    end
  end

  def remove_wagons
    print 'Train number: '
    number = gets.chomp
    print 'Wagons number: '
    wagons_number = gets.to_i
    if @trains[number]
      @trains[number].remove_wagons(wagons_number)
    else
      puts 'Train does not exist'
    end
  end

  def add_train
    print 'Train number: '
    number = gets.chomp
    print 'Station name: '
    name = gets.chomp
    if @stations[name] && @trains[number]
      @stations[name].add(@trains[number])
    else
      puts 'Station or train do not exist'
    end
  end

  def show_trains
    print 'Station name: '
    name = gets.chomp
    if @stations[name]
      @stations[name].show
    else
      puts 'Station does not exist'
    end
  end
end
