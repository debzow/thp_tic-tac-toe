require "awesome_print"
require_relative "key_pressed"
require_relative "BoardCase"
require_relative "Board"
require_relative "Player"

class Game

  #On créé les instances des 3 autres classes
  PLAYER = Player.new
  BOARDCASE = BoardCase.new
  BOARD = Board.new

  def initialize #On y définit les variables qui ne changeront jamais
    @players_names = PLAYER.definition
    @score = [0, 0]
    @shapes = ["X", "O"]
    @win_positions = [["h1", "h2", "h3"], ["m1", "m2", "m3"], ["b1", "b2", "b3"],
                      ["h1", "m1", "b1"], ["h2", "m2", "b2"], ["h3", "m3", "b3"],
                      ["h1", "m2", "b3"], ["b1", "m2", "h3"]]
                      #Ce sont les 8 combinaisons gagnantes
  end

  def newturn_player(currentplayer, players_names) #A chaque appel de cette fonction, on change le joueur
    (currentplayer == players_names[0]) ? (return players_names[1]) : (return players_names[0])
  end

  def newturn_shape(currentshape) #A chaque appel de cette fonction, on change la forme (X ou O)
    (currentshape == "X") ? (return "O") : (return "X")
  end

  def checkwin(cases, win_positions) #On vérifie si un joueur a gagné
    win_positions.each do |combo| #Pour chaque combinaison gagnante
      if cases[combo[0]][2] == 'X' && cases[combo[1]][2] == 'X' && cases[combo[2]][2] == 'X'
        return 1 #Le joueur 1 a gagné
      elsif cases[combo[0]][2] == 'O' && cases[combo[1]][2] == 'O' && cases[combo[2]][2] == 'O'
        return 2 #Le joueur 2 a gagné
      end
    end
  end

  def victory(win, count, score, cases, currentplayer, currentshape, currentselected, players_names)
    start_line = "                " #On réutilise ces espaces plus bas pour mieux centrer le contenu
    bottom_line = "                           _________________________\n\n" #La ligne qui sert à séparer le jeu du message de victoire
    if win == 1 #Si c'est le joueur 1 qui a gagné
      score[0] += 1 #Alors il gagne un point
      BOARD.printboard(cases, currentplayer, currentshape, currentselected, score, players_names) #On actualise pour afficher le nouveau score
      puts "#{start_line}                 #{players_names[0]} gagne !             \n".upcase.yellow
      puts bottom_line
    elsif win == 2 #Si c'est le joueur 2 qui a gagné
      score[1] += 1
      BOARD.printboard(cases, currentplayer, currentshape, currentselected, score, players_names) #On actualise pour afficher le nouveau score
      puts "#{start_line}                 #{players_names[1]} gagne !             \n".upcase.yellow
      puts bottom_line
    elsif count == 9 #Si les 9 cases sont remplies
      puts "#{start_line}               C'est une égalité !      \n".upcase.yellow
      puts bottom_line
    end
    if win == 1 || win == 2 || count >= 9 #Si la partie est terminée
      puts "                            Souhaitez-vous rejouer ?\n".cyan
      puts "                        #{"[ENTREE] = ".yellow} #{"Relancer une partie".red}"
      puts "                              #{"[CTRL-C] = ".yellow} #{"Quitter".red}\n\n"
      while 1 #On récupère la pression des touches CTRL-C et ENTER
        c = show_single_key
        if c == "ENTER" #Si la touche est appuyée
          launch #On relance une aprtie
        elsif c == "CTRL-C" #Si CTRL-C est fait
          puts "\n\n                                  Au revoir !\n".green
          exit #On quitte le jeu
        end
      end
    end
  end

  def launch #Lance une partie
    random = rand(0-2) #Génère soit 1 soit 0
    currentplayer = @players_names[random] #Le joueur qui commence est choisit aléatoirement
    currentshape = @shapes[random] #On fait correspondre la forme (X ou O) au joueur choisit aléaoirement
    cases = {"h1" => "     ", "h2" => "     ", "h3" => "     ", "m1" => "     ", "m2" => "     ", "m3" => "     ", "b1" => "     ", "b2" => "     ", "b3" => "     "}
    #Toutes les cases du morpion
    selected = 0 #On met la position du curseur à 0
    count = 0 #On met le nombre de cases remplies à 0
    currentselected = 0
    BOARD.printboard(cases, currentplayer, currentshape, currentselected, @score, @players_names)
    #On actualise de base et après chaque tour
    while 1
      selected = BOARDCASE.selector(currentselected, currentshape) #On permet à l'utilisateur de bouger le curseur
      if selected == "ENTER" #Si il ne le bouge pas et que il confirme la sélection
        if BOARDCASE.check_case(currentselected, cases) == "EMPTY" #Et que la case est vide (pour éviter d'écraser une case déjà remplie)
          count += 1 #Alors il y a une case remplie de plus
          cases = BOARDCASE.putcase(currentselected, currentshape, cases) #On insère la nouvelle valeur dans la case
          currentplayer = newturn_player(currentplayer, @players_names) #On change le joueur actuel
          currentshape = newturn_shape(currentshape) #On change aussi sa forme
          BOARD.printboard(cases, currentplayer, currentshape, currentselected, @score, @players_names) #On actualise l'affichage
          victory(checkwin(cases, @win_positions), count, @score, cases, currentplayer, currentshape, currentselected, @players_names)
          #On vérifie s'il y a un cas de victoire
        end
      else #Si l'utilisateur n'a pas confirmer la sélection, et l'a juste bougé
        currentselected = selected #Alors currentselected est égal à la réelle position de la sélection (et non "ENTER")
        BOARD.printboard(cases, currentplayer, currentshape, currentselected, @score, @players_names)
        #On actualiste l'affichage avec la nouvelle position de la sélection
      end
    end
  end
end
