require "pry"

puts "|///////////////////////////////////////////////////////////////|"
    puts "|                        Bienvenue sur                          |"
    puts "|                          'MORPION'                            |"
    puts "|                            1 VS 1                             |"
    puts "|                  dans le TERMINAL du GHETTO                   |"
    puts "|///////////////////////////////////////////////////////////////|"
     

class BoardCase
  attr_accessor :case, :id
  
  def initialize(lacase, leid)
    @case = lacase
    @id = leid
  end
end

class Board
  attr_accessor :array_cases
  
  def initialize

    @A1 = BoardCase.new(" ", 1)
    @A2 = BoardCase.new(" ", 2)
    @A3 = BoardCase.new(" ", 3)
    @B1 = BoardCase.new(" ", 4)
    @B2 = BoardCase.new(" ", 5)
    @B3 = BoardCase.new(" ", 6)
    @C1 = BoardCase.new(" ", 7)
    @C2 = BoardCase.new(" ", 8)
    @C3 = BoardCase.new(" ", 9)

    
    @array_cases = [@A1, @A2, @A3, @B1, @B2, @B3, @C1, @C2, @C3]
  end
  
  def play_turn(player)
    puts "#{player.name}, c'est à vous de jouer. Choisissez un numéro de case (1 à 9) la premiere colonne va de 1 à 3 en partant de gauche à droite et ainsi de suite pour les colonnes suivantes : "
    selected_case = gets.chomp.to_i

    board_case = array_cases.find { |case_obj| case_obj.id == selected_case }
    if board_case
      board_case.case = player.symbol
    else
      puts "Case invalide. Veuillez choisir un numéro de case parmi 1 à 9."
      play_turn(player)
    end
  end

  def display_board
    def display_board
      puts "\n"
      puts " #{@A1.case} | #{@A2.case} | #{@A3.case}"
      puts "---+---+---"
      puts " #{@B1.case} | #{@B2.case} | #{@B3.case}"
      puts "---+---+---"
      puts " #{@C1.case} | #{@C2.case} | #{@C3.case}"
      puts "\n"
    end
  end

  def victory?
    winning_combinations = [
      [@A1, @A2, @A3], [@B1, @B2, @B3], [@C1, @C2, @C3],
      [@A1, @B1, @C1], [@A2, @B2, @C2], [@A3, @B3, @C3], 
      [@A1, @B2, @C3], [@A3, @B2, @C1]
    ]

    winning_combinations.each do |combination|
      if combination.all? { |case_obj| case_obj.case == "X" } ||
         combination.all? { |case_obj| case_obj.case == "O" }
        return true
      end
    end
    
    false
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize
    puts "Joueur 1, entrez votre nom :"
    name1 = gets.chomp
    @player1 = Player.new(name1, "X")
    
    puts "Joueur 2, entrez votre nom :"
    name2 = gets.chomp
    @player2 = Player.new(name2, "O")
    
    @board = Board.new
    @current_player = @player1
  end
  
  def turn
    @board.display_board
    @board.play_turn(@current_player)

    if @board.victory?
      @board.display_board
      puts "#{@current_player.name} a éradiqué la vermine ! Félicitations pour cette humiliation !"
    else
      switch_player
    end
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def new_round
    @board = Board.new
    @current_player = @player1
    play
  end

  def play
    turn until @board.victory?
    puts "Partie terminée ! Voulez-vous rejouer ? (Oui/Non)"
    response = gets.chomp.downcase

    if response == "oui"
      new_round
    else
      puts "Merci d'avoir joué ! À bientôt !"
    end
  end
end

Game.new.play