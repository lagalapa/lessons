months = %w( January February March April May June July August September
             October November December )
days_number = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_months = Hash[months.zip(days_number)]
puts 'The months in which 30 days:'
days_in_months.each { |month, days| puts month if days == 30 }
