input = File.read('2.in').split("\n")[0].split(",").map(&:to_i)

0.upto(99) do |noun|
  0.upto(99) do |verb|
    memory = input.clone
    memory[1] = noun
    memory[2] = verb

    index = 0
    while index < memory.length
        code = memory[index]
        break if code == 99

        a = memory[index + 1]
        b = memory[index + 2]
        out = memory[index + 3]

        memory[out] = code == 1 ? memory[a] + memory[b] : memory[a] * memory[b]
        index += 4
    end
    puts (100 * noun + verb) if memory[0] == 19690720
  end
end