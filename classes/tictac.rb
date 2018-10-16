require "awesome_print"
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
      elsif c == "ENTER"
        return "ENTER"
        break
      end
    end
    return selected
  end

  def putcase(selected, currentshape, cases)
    #puts "  " + currentshape + "  "
    cases[cases.keys[selected]] = "  " + currentshape + "  "
    return cases
  end

end

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

  def printboard(cases, currentplayer, currentshape, selected)
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
    puts "#{start_line}                 > Forme : #{currentshape} < \n".blue
    puts "#{space}\n#{space}\n#{line1}\n#{space}\n#{lines}\n#{space}\n#{space}\n#{line2}\n#{space}\n#{lines}\n#{space}\n#{space}\n#{line3}\n#{space}\n#{space}\n"
    puts "\n#{start_line}#{"(Appuyez sur ENTREE pour confirmer votre choix)".yellowish}\n\n"
    puts case_state
  end

end


class Player

  def definition
    print "\n\nComment s'appelle le joueur qui fera les croix ?\n> ".yellow
    puts "Bienvenue à toi #{player1 = gets.chomp} !".green
    print "\n\nComment s'appelle le joueur qui fera les ronds ?\n> ".yellow
    puts "Bienvenue à toi #{player2 = gets.chomp} !".green
    return [player1, player2]
  end
end


class Game

  PLAYER = Player.new
  BOARDCASE = BoardCase.new
  BOARD = Board.new

  def initialize
    @players_names = PLAYER.definition
    random = rand(0-2)
    shapes = ["X", "O"]
    @currentplayer = @players_names[random]
    @currentshape = shapes[random]
    @cases = {"h1" => "     ", "h2" => "     ", "h3" => "     ", "m1" => "     ", "m2" => "     ", "m3" => "     ", "b1" => "     ", "b2" => "     ", "b3" => "     "}
    @win_positions = [["h1", "h2", "h3"], ["m1", "m2", "m3"], ["b1", "b2", "b3"],
                      ["h1", "m1", "b1"], ["h2", "m2", "b2"], ["h3", "m3", "b3"],
                      ["h1", "m2", "b3"], ["b1", "m2", "h3"]]
    @selected = 0
    @count = 0
    @currentselected = 0
    @win = 0
  end

  def newturn_player(currentplayer, players_names)
    (currentplayer == players_names[0]) ? (return players_names[1]) : (return players_names[0])
  end

  def newturn_shape(currentshape)
    (currentshape == "X") ? (return "O") : (return "X")
  end

  def checkwin(cases, win_positions)
    win_positions.each do |combo|
      #puts "premier combo : #{cases[combo[0]][2] == 'X'}, deuxième : #{cases[combo[1]][2] == 'X'}, troisième : #{cases[combo[2]][2] == 'X'}"
      if cases[combo[0]][2] == 'X' && cases[combo[1]][2] == 'X' && cases[combo[2]][2] == 'X'
        return 1
      elsif cases[combo[0]][2] == 'O' && cases[combo[1]][2] == 'O' && cases[combo[2]][2] == 'O'
        return 2
      end
    end
  end

  def victory(win, count)
    start_line = "                                      "
    bottom_line = "                                                 _________________________"
    if win == 1
      puts "\n#{start_line}                 #{@players_names[0]} gagne !\n".upcase.yellow
      puts bottom_line
    elsif win == 2
      puts "\n#{start_line}                 #{@players_names[1]} gagne !\n".upcase.yellow
      puts bottom_line
    elsif count == 9
      puts "\n#{start_line}               C'est une égalité !\n".upcase.yellow
      puts bottom_line

    end
    #if win == 1 || win == 2 || count >= 9

  end

  def launch

    while 1
      BOARD.printboard(@cases, @currentplayer, @currentshape, @currentselected)
      while 1
        @selected = BOARDCASE.selector(@currentselected, @currentshape)
        if @selected == "ENTER"
          if BOARDCASE.check_case(@currentselected, @cases) == "EMPTY"
            @count += 1
            puts @count
            @cases = BOARDCASE.putcase(@currentselected, @currentshape, @cases)
            @currentplayer = newturn_player(@currentplayer, @players_names)
            @currentshape = newturn_shape(@currentshape)
            BOARD.printboard(@cases, @currentplayer, @currentshape, @currentselected)
            victory(checkwin(@cases, @win_positions), @count)
          end
        else
          @currentselected = @selected
          BOARD.printboard(@cases, @currentplayer, @currentshape, @currentselected)
        end
      end

      @currentplayer = newturn_player(@currentplayer, @players_names)
      @currentshape = newturn_shape(@currentshape)
      sleep(1)
    end
  end
end
