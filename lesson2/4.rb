hash = ('a'..'z').zip(1..26).to_h
vowels = 'aeiou'
hash.select! { |letter, _number| vowels.include?(letter) }
