require_relative "key_pressed"

class BoardCase

  def check_case(selected, cases)
    casevalue = cases[cases.keys[selected]]
    if casevalue == "     "
      return "EMPTY"
    elsif casevalue == "  X  "
      return "X"
    elsif casevalue == "  O  "
      return "O"
    end
  end

  def selector(selected, currentshape)
    while 1
      c = show_single_key
      if c == "RIGHT" && selected != 8
        selected += 1
        break
      elsif c == "LEFT" && selected != 0
        selected -= 1
        break
      elsif c == "UP" && selected >= 3
        selected -= 3
        break
      elsif c == "DOWN" && selected <= 5
        selected += 3
        break
      elsif c == "CTRL-C"
        puts "\n\n                                  Au revoir !\n".green
        exit
      elsif c == "ENTER"
        return "ENTER"
        break
      end
    end
    return selected
  end

  def putcase(selected, currentshape, cases)
    cases[cases.keys[selected]] = "  " + currentshape + "  "
    return cases
  end

end
