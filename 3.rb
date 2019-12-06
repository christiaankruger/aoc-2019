    require 'set'

    def build_coordinates_array (w) 
      x = 0
      y = 0
      w.reduce([]) do |memo, cmd|
        direction = cmd[0]
        steps = cmd[1..-1].to_i
        while steps > 0
          x -= 1 if direction == "L"
          x += 1 if direction == "R"
          y += 1 if direction == "U"
          y -= 1 if direction == "D"

          memo.push("#{x},#{y}")
          steps -= 1
        end
        memo
      end
    end

    # Line 1 = Wire 1
    # Line 2 = Wire 2
    input = File.read('3.in').split("\n")
    w1 = input[0].split(",")
    w2 = input[1].split(",")

    arr_w1 = build_coordinates_array(w1)
    arr_w2 = build_coordinates_array(w2)

    intersection_arr = (arr_w1.to_set & arr_w2.to_set).to_a

    # Part A
    puts intersection_arr.map { |intersection| intersection.split(",").map(&:to_i).reduce(0) { |memo, x| memo + x.abs }}.min

    # Part B
    mapped = intersection_arr.map do |intersection|
      w1_steps = arr_w1.find_index(intersection) + 1
      w2_steps = arr_w2.find_index(intersection) + 1
      w1_steps + w2_steps
    end

    puts mapped.min