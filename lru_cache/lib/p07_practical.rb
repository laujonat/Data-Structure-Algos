require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = HashMap.new

  string.chars.each do |char|
    if hash[char]
      hash[char] += 1
    else
      hash[char] = 1
    end
  end

  count_odds = 0
  hash.each do |char, count|
    count_odds += 1 if count % 2 == 1
    return false if count_odds > 1
  end
  true
end

#
# a b c c
# b a a b
# a t t t a
# b a a a b
# h o o o o h  
#
#
#
