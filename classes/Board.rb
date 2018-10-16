require_relative "BoardCase"

class Board

  BOARDCASE = BoardCase.new

  def shape_color(shape) #Retourne la forme en couleur en fonction de si c'est X ou O
    if shape[2] == "X"
      return ("  X  ".cyan)
    elsif shape[2] == "O"
      return ("  O  ".red)
    else
      return ("     ") #Sinon, on retourne le vide
    end
  end

  def printboard(cases, currentplayer, currentshape, selected, score, players_names) #Affiche le jeu
    cases_select = cases.dup #On fait ça pour éviter que "cases" soit modifié contre notre gré
    cases_color = cases_select.dup #cases_select garde les cases telles quelles, et cases_color affiche en couleur
    cases_color.transform_values! {|v| v = shape_color(v)} #On modifie chaque case en case colorée
    if cases_select[cases_select.keys[selected]][2] == "X" #Si la case sélectionnée détient un X
      cases_color[cases_color.keys[selected]] = "#{">".blue} #{"X".cyan} #{"<".blue}"
    elsif cases_select[cases_select.keys[selected]][2] == "O" #Si la case sélectionnée détient un O
      cases_color[cases_color.keys[selected]] = "#{">".blue} #{"O".red} #{"<".blue}"
    else #Si la case sélectionnée ne détient rien
      cases_color[cases_color.keys[selected]] = ">   <".blue
    end
    #Vérifie l'état de la case, si elle est prise
    if BOARDCASE.check_case(selected, cases) == "X" || BOARDCASE.check_case(selected, cases) == "O" #Si la case est occupée
      case_state = "                            Cette case est occupée !".red
    else #Si la case est vide
      case_state = "                             Cette case est libre !".cyan
    end

    start_line = "                " #On réutilise ces espaces plus bas pour mieux centrer le contenu
    line1 = "#{start_line}             #{cases_color["h1"]} | #{cases_color["h2"]} | #{cases_color["h3"]}" #On affiche les cases
    line2 = "#{start_line}             #{cases_color["m1"]} | #{cases_color["m2"]} | #{cases_color["m3"]}"
    line3 = "#{start_line}             #{cases_color["b1"]} | #{cases_color["b2"]} | #{cases_color["b3"]}"
    lines = "#{start_line}           ________|_______|________"
    space = "#{start_line}                   |       |       "
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    #On fait plein de retours à la ligne pour simuler une actualisation
    puts "  ______    _                 ______                        ______             ".red #Affiche un joli titre tout beau
    puts " /_  __/   (_)  _____        /_  __/  ____ _  _____        /_  __/  ____   ___ ".red
    puts "  / /     / /  / ___/ ______  / /    / __ `/ / ___/ ______  / /    / __ \\ / _ \\".red
    puts " / /     / /  / /__  /_____/ / /    / /_/ / / /__  /_____/ / /    / /_/ //  __/".red
    puts "/_/     /_/   \\___/         /_/     \\__,_/  \\___/         /_/     \\____/ \\___/ \n\n".red
    puts "#{start_line}        C'est au tour de #{currentplayer} de jouer !\n".yellow
    if currentshape == "X"
      puts "#{start_line}                 #{"> Forme : ".blue}#{currentshape.cyan}#{" <".blue}\n\n"
    elsif currentshape == "O"
      puts "#{start_line}                 #{"> Forme : ".blue}#{currentshape.red}#{" <".blue}\n\n"
    end
    if score[0] < 2 #On gère l'écriture au pluriel si le joueur 1 a plus de 2 points
      puts "   #{players_names[0].cyan} a #{score[0].to_s.red} point !".yellow
    else
      puts "   #{players_names[0].cyan} a #{score[0].to_s.red} points !".yellow
    end
    if score[1] < 2 #On gère l'écriture au pluriel si le joueur 2 a plus de 2 points
      puts "                                                           #{players_names[1].cyan} a #{score[1].to_s.red} point !\n".yellow
    else
      puts "                                                           #{players_names[1].cyan} a #{score[1].to_s.red} points !\n".yellow
    end
    puts "#{space}\n#{space}\n#{line1}\n#{space}\n#{lines}\n#{space}\n#{space}\n#{line2}\n#{space}\n#{lines}\n#{space}\n#{space}\n#{line3}\n#{space}\n#{space}\n"
    #Ici, on affiche toute la grille avec des retours à la ligne entre chaque ligne
    puts "\n#{start_line}#{"(Appuyez sur ENTREE pour confirmer votre choix)".yellowish}"
    puts "#{start_line}             #{"([CTRL-C] = Quitter)".yellowish}\n\n"
    print "#{case_state}\r" #On affiche l'état de la case sélectionnée (si elle est occupée ou non)
  end

end
