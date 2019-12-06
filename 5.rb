input = File.read('5.in').split("\n")[0].split(",").map(&:to_i)

def dissect command
    command_arr = command.to_s.split("")
    len = command_arr.length
    # Make sure we have 5 digits in our array
    len.upto(5 - 1).each {|x| command_arr.unshift("0")}
    opcode = [command_arr[5-2], command_arr[5-1]].join("").to_i
    params = []
    (5 - 3).downto(0) do |i|
        params.push(command_arr[i].to_i)
    end
    {
        opcode: opcode,
        params: params
    }
end


memory = input.clone
input = 5

index = 0
while index < memory.length
    code = memory[index]
    break if code == 99

    command = dissect(code)
    puts command.inspect
    
    opcode = command[:opcode]
    op_params = command[:params]

    if opcode == 3
        slot = memory[index + 1]
        memory[slot] = input
        index += 2
        next
    end

    if opcode == 4
        param = op_params[0]
        if param == 0
            # Position
            puts memory[memory[index + 1]]
        else 
            # Immediate
            puts memory[index + 1]
        end
        index += 2
        next
    end

    if opcode == 5
        param_1 = op_params[0] == 0 ? memory[memory[index + 1]] : memory[index + 1]
        param_2 = op_params[1] == 0 ? memory[memory[index + 2]] : memory[index + 2]

        if param_1 != 0
            index = param_2
        else
            index += 3
        end
        next
    end

    if opcode == 6
        param_1 = op_params[0] == 0 ? memory[memory[index + 1]] : memory[index + 1]
        param_2 = op_params[1] == 0 ? memory[memory[index + 2]] : memory[index + 2]

        if param_1 == 0
            index = param_2
        else
            index += 3
        end
        next
    end

    if opcode == 7
        param_1 = op_params[0] == 0 ? memory[memory[index + 1]] : memory[index + 1]
        param_2 = op_params[1] == 0 ? memory[memory[index + 2]] : memory[index + 2]
        param_3 = op_params[2] == 0 ? memory[index + 3] : index + 3

        memory[param_3] = param_1 < param_2 ? 1 : 0
        index += 4
        next
    end

    if opcode == 8
        param_1 = op_params[0] == 0 ? memory[memory[index + 1]] : memory[index + 1]
        param_2 = op_params[1] == 0 ? memory[memory[index + 2]] : memory[index + 2]
        param_3 = op_params[2] == 0 ? memory[index + 3] : index + 3

        memory[param_3] = param_1 == param_2 ? 1 : 0
        index += 4
        next
    end


    a = op_params[0] == 0 ? memory[index + 1] : index + 1
    b = op_params[1] == 0 ? memory[index + 2] : index + 2
    out = memory[index + 3] # Output is always positional

    puts "a is #{a}, b is #{b}, out is #{out}"
    puts "memory[a] is #{memory[a]}, memory[b] is #{memory[b]}"
    

    memory[out] = opcode == 1 ? memory[a] + memory[b] : memory[a] * memory[b]
    index += 4
end

puts memory.inspect