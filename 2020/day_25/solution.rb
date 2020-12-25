key1, key2 = 14082811, 5249543

DIV = 20201227

def loop_size(key, subject_number = 7, loop_size = 0, n = 1)
  until n == key
    n = (n * subject_number) % DIV
    loop_size += 1
  end

  loop_size
end

def encryption_key(subject_number, loop_size, n = 1)
  loop_size.times do
    n = (n * subject_number) % DIV
  end

  n
end

loop_size = loop_size(key1)

result = encryption_key(key2, loop_size)

puts "The puzzle answer is #{result}"
