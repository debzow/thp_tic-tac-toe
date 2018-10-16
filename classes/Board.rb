require_relative "BoardCase"

class Board

  BOARDCASE = BoardCase.new

  def shape_color(shape)
    if shape[2] == "X"
      return ("  X  ".cyan)
    elsif shape[2] == "O"
      return ("  O  ".red)
    else
      return ("     ")
    end
  end

  def printboard(cases, currentplayer, currentshape, selected, score, players_names)
    cases_select = cases.dup
    cases_color = cases_select.dup
    cases_color.transform_values! {|v| v = shape_color(v)}
    if cases_select[cases_select.keys[selected]][2] == "X"
      cases_color[cases_color.keys[selected]] = "#{">".blue} #{"X".cyan} #{"<".blue}"
    elsif cases_select[cases_select.keys[selected]][2] == "O"
      cases_color[cases_color.keys[selected]] = "#{">".blue} #{"O".red} #{"<".blue}"
    else
      cases_color[cases_color.keys[selected]] = ">   <".blue
    end
    #Vérifie l'état de la case, si elle est prise
    if BOARDCASE.check_case(selected, cases) == "X" || BOARDCASE.check_case(selected, cases) == "O"
      case_state = "                           Cette case est occupée !".red
    else
      case_state = "                            Cette case est libre !".cyan
    end

    start_line = "                "
    line1 = "#{start_line}             #{cases_color["h1"]} | #{cases_color["h2"]} | #{cases_color["h3"]}"
    line2 = "#{start_line}             #{cases_color["m1"]} | #{cases_color["m2"]} | #{cases_color["m3"]}"
    line3 = "#{start_line}             #{cases_color["b1"]} | #{cases_color["b2"]} | #{cases_color["b3"]}"
    lines = "#{start_line}           ________|_______|________"
    space = "#{start_line}                   |       |       "
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    puts "  ______    _                 ______                        ______             ".red
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
    puts "   #{players_names[0].cyan} a #{score[0].to_s.red} points !".yellow
    puts "                                                           #{players_names[1].cyan} a #{score[1].to_s.red} points !\n".yellow
    puts "#{space}\n#{space}\n#{line1}\n#{space}\n#{lines}\n#{space}\n#{space}\n#{line2}\n#{space}\n#{lines}\n#{space}\n#{space}\n#{line3}\n#{space}\n#{space}\n"
    puts "\n#{start_line}#{"(Appuyez sur ENTREE pour confirmer votre choix)".yellowish}"
    puts "#{start_line}             #{"([CTRL-C] = Quitter)".yellowish}\n\n"
    print "#{case_state}\r"
  end

end
