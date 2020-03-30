require 'pry'

class TicTacToe
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
    @xs = []
    @os = []
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end


  def input_to_index(index)
    index.to_i - 1
  end

  def move(index, mark)
    @board[index] = mark
    if mark == "X"
      @xs << index
    else
      @os << index
    end
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O" ? true : false
  end

  def valid_move?(index)
    allowed_characters = [0,1,2,3,4,5,6,7,8]
    if allowed_characters.include?(index) && @board[index] != "X" && @board[index] != "O"
      true
    else
      false
    end
  end

  def turn_count
    turns = @board.select do |mark|
      mark == "X" || mark == "O"
    end
    turns.length
  end

  def current_player
    x = @board.select do |mark|
      mark == "X"
    end
    o = @board.select do |mark|
      mark == "O"
    end

    if x.length > o.length
      "O"
    else
      "X"
    end
  end

  def turn
    mark = current_player
    puts "#{mark}'s turn, enter a number 1 - 9"
    input = gets.chomp
    index = input_to_index(input)
    vm = valid_move?(index)
    if vm && !full?
      move(index, mark)
      display_board
      won?
    elsif full?
      winner("draw")
    else
      puts "Space occupied, try another"
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if combo - @xs == []
        winner("X")
      elsif combo - @os == []
        winner("O")
      else
        turn
      end
    end
  end

  def full?
    if turn_count == 9
      puts "All spaces full!"
      true
    else
      false
    end
  end

  def draw?
    puts "It's a draw!"
  end

  def over?
    puts "Game Over"
  end

  def winner(player)
    if player == "X"
      puts "X is the winner!"
      over?
    elsif player == "O"
      puts "O is the winner!"
      over?
    elsif player == "draw"
      draw?
      over?
    end
  end
end
