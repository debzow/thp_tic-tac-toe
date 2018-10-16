require_relative "key_pressed"

class BoardCase

  def check_case(selected, cases) #Vérifie l'état de la case et renvoie l'état
    casevalue = cases[cases.keys[selected]] #On récupère la case sélectionnée
    if casevalue == "     "
      return "EMPTY"
    elsif casevalue == "  X  "
      return "X"
    elsif casevalue == "  O  "
      return "O"
    end
  end

  def selector(selected, currentshape) #Bouge la position du curseur
    while 1 #Tant que l'utilisateur n'a pas rentré une des touches voulues
      c = show_single_key
      if c == "RIGHT" && selected != 8 && selected != 5 && selected != 2
        selected += 1
        break
      elsif c == "LEFT" && selected != 0 && selected != 3 && selected != 6
        selected -= 1
        break
      elsif c == "UP" && selected >= 3
        selected -= 3
        break
      elsif c == "DOWN" && selected <= 5
        selected += 3
        break
      elsif c == "CTRL-C" #Si l'utilisateur quitte
        puts "\n\n                                  Au revoir !\n".green
        exit
      elsif c == "ENTER"
        return "ENTER"
        break
      end
    end
    return selected #On retourne et enregistre la nouvelle position du curseur
  end

  def putcase(selected, currentshape, cases)
    #Si l'utilisateur sélectionne une case, cette fonction remplace la valeur de la case par la forme voulue (X ou O)
    cases[cases.keys[selected]] = "  " + currentshape + "  "
    return cases #On retourne la liste des cases actualisée
  end

end
