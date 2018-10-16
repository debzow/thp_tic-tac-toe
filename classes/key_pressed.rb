require 'io/console'

def read_char
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def show_single_key
  char = read_char

  case char
  when "\r"
    return "ENTER"
  when "\e[A"
    return "UP"
  when "\e[B"
    return "DOWN"
  when "\e[C"
    return "RIGHT"
  when "\e[D"
    return "LEFT"
  when "\u0003"
    return "CTRL-C"
  else
    return false
  end
end
