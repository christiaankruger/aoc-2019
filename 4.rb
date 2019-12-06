RANGE_START = 235741
RANGE_END = 706948

result = RANGE_START.upto(RANGE_END).select do |x|
  x_s = x.to_s

  prev = x_s[0].to_i
  valid_dec = true
  valid_double = false

  1.upto(x_s.length - 1) do |i|
    c = x_s[i].to_i
    valid_dec = false if c < prev
    # Part A
    # valid_double = true if c == prev
    # Part B
    valid_double = true if c == prev && c != x_s[i - 2].to_i && c != x_s[i + 1].to_i
    prev = c
  end
  valid_dec && valid_double
end

puts result.length