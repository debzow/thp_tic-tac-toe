require "awesome_print"
require_relative "key_pressed"
require_relative "BoardCase"
require_relative "Board"
require_relative "Player"

class Game

  PLAYER = Player.new
  BOARDCASE = BoardCase.new
  BOARD = Board.new

  def initialize
    @players_names = PLAYER.definition
    @score = [0, 0]
    @shapes = ["X", "O"]
    @win_positions = [["h1", "h2", "h3"], ["m1", "m2", "m3"], ["b1", "b2", "b3"],
                      ["h1", "m1", "b1"], ["h2", "m2", "b2"], ["h3", "m3", "b3"],
                      ["h1", "m2", "b3"], ["b1", "m2", "h3"]]
  end

  def newturn_player(currentplayer, players_names)
    (currentplayer == players_names[0]) ? (return players_names[1]) : (return players_names[0])
  end

  def newturn_shape(currentshape)
    (currentshape == "X") ? (return "O") : (return "X")
  end

  def checkwin(cases, win_positions)
    win_positions.each do |combo|
      if cases[combo[0]][2] == 'X' && cases[combo[1]][2] == 'X' && cases[combo[2]][2] == 'X'
        return 1
      elsif cases[combo[0]][2] == 'O' && cases[combo[1]][2] == 'O' && cases[combo[2]][2] == 'O'
        return 2
      end
    end
  end

  def victory(win, count, score, cases, currentplayer, currentshape, currentselected, players_names)
    start_line = "                "
    bottom_line = "                           _________________________\n\n"
    if win == 1
      score[0] += 1
      BOARD.printboard(cases, currentplayer, currentshape, currentselected, score, players_names)
      puts "#{start_line}                 #{players_names[0]} gagne !      \n".upcase.yellow
      puts bottom_line
    elsif win == 2
      score[1] += 1
      BOARD.printboard(cases, currentplayer, currentshape, currentselected, score, players_names)
      puts "#{start_line}                 #{players_names[1]} gagne !      \n".upcase.yellow
      puts bottom_line
    elsif count == 9
      puts "#{start_line}               C'est une égalité !      \n".upcase.yellow
      puts bottom_line
    end
    if win == 1 || win == 2 || count >= 9
      puts "                            Souhaitez-vous rejouer ?\n".cyan
      puts "                        #{"[ENTREE] = ".yellow} #{"Relancer une partie".red}"
      puts "                              #{"[CTRL-C] = ".yellow} #{"Quitter".red}\n\n"
      while 1
        c = show_single_key
        if c == "ENTER"
          launch
        elsif c == "CTRL-C"
          puts "\n\n                                  Au revoir !\n".green
          exit
        end
      end
    end
  end

  def launch
    random = rand(0-2)
    currentplayer = @players_names[random]
    currentshape = @shapes[random]
    cases = {"h1" => "     ", "h2" => "     ", "h3" => "     ", "m1" => "     ", "m2" => "     ", "m3" => "     ", "b1" => "     ", "b2" => "     ", "b3" => "     "}
    selected = 0
    count = 0
    currentselected = 0
    while 1
      BOARD.printboard(cases, currentplayer, currentshape, currentselected, @score, @players_names)
      while 1
        selected = BOARDCASE.selector(currentselected, currentshape)
        if selected == "ENTER"
          if BOARDCASE.check_case(currentselected, cases) == "EMPTY"
            count += 1
            puts count
            cases = BOARDCASE.putcase(currentselected, currentshape, cases)
            currentplayer = newturn_player(currentplayer, @players_names)
            currentshape = newturn_shape(currentshape)
            BOARD.printboard(cases, currentplayer, currentshape, currentselected, @score, @players_names)
            victory(checkwin(cases, @win_positions), count, @score, cases, currentplayer, currentshape, currentselected, @players_names)
          end
        else
          currentselected = selected
          BOARD.printboard(cases, currentplayer, currentshape, currentselected, @score, @players_names)
        end
      end
      currentplayer = newturn_player(currentplayer, @players_names)
      currentshape = newturn_shape(currentshape)
    end
  end
end
