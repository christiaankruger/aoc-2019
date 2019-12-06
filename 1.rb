def cost x
  (x / 3) - 2
end

def total_cost x
  sum = 0
  x = cost(x)
  while x > 0
    sum += x
    x = cost(x)
  end
  sum
end


input = File.read("1.in").split("\n")
puts input.map(&:to_i).map{ |x| total_cost(x) }.reduce(0) { |memo, x | memo + x }