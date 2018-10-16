class Player

  def definition #Demande le nom des joueurs
    begin
      print "\n\n#{"Quel est le nom du premier joueur ?".yellow}\n#{">".red} ".yellow
      print "Enchanté #{(player1 = gets.chomp)} ! Tu feras les croix.".green
      print "\n\n#{"Quel est le nom du second joueur ?".yellow}\n#{">".red} ".yellow
      print "Bienvenue à toi #{player2 = gets.chomp} ! Tu feras les ronds.\r".green
      sleep(1)
      print "Bienvenue à toi #{player2} ! Tu feras les ronds..\r".green
      sleep(1) #On attend deux secondes pour laisser l'utilisateur lire
      return [player1, player2]
    rescue Interrupt #Si l'utilisateur fait CTRL-C
      puts "\n\nAu revoir !\n".green
      exit #On quitte le jeu
    end
  end
end
