class Player

  def definition
    begin
      print "\n\nComment s'appelle le joueur qui fera les croix ?\n> ".yellow
      puts "Bienvenue à toi #{player1 = gets.chomp} !".green
      print "\n\nComment s'appelle le joueur qui fera les ronds ?\n> ".yellow
      puts "Bienvenue à toi #{player2 = gets.chomp} !".green
      return [player1, player2]
    rescue Interrupt #Si l'utilisateur fait CTRL-C
      puts "\n\nAu revoir !\n".green
    end
  end
end
