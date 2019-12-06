input = File.read("6.in").split("\n").to_a

adj_mx = []

# Count number of planets
all_planets = input.map { |line| line.split(")") }.flatten.uniq

empty_row = all_planets.map { |x| nil }
adj_mx = all_planets.map {|x| empty_row.clone }

input.map { |line| line.split(")")}.each do |pair|
  from = all_planets.find_index { |planet| planet == pair[0]}
  to = all_planets.find_index { |planet| planet == pair[1]}

  adj_mx[from][to] = 1
  adj_mx[to][from] = 1
end

count = 0
level = 1

queue = []
visited = {}

queue.push({
  target: all_planets.find_index{|planet| planet == "YOU"},
  level: 0
})

while queue.length > 0
  t = queue.pop()
  target = t[:target]
  level = t[:level]

  if all_planets[target] == "SAN"
    # FOUND!
    break
  end

  visited[target] = true
  0.upto(adj_mx[target].length - 1) do |j|
    next if visited[j]
    queue.push({
      target: j,
      level: level + 1
    }) if adj_mx[target][j] == 1
  end
end

puts level - 2