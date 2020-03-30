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
      return true
    else
      return false
    end
  end

  def turn_count
    turns = @board.select do |mark|
      mark == "X" || mark == "O"
    end
    turns.length
  end

  def current_player
    if turn_count.even?
      "X"
    else
      "O"
    end
  end

  def turn
    mark = current_player
    puts "#{mark}'s turn, enter a number 1 - 9"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index) && !full?
      move(index, mark)
      display_board
    else
      puts "Space occupied, try another"
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if combo - @xs == [] || combo - @os == []
        return combo
      else
        return false
      end
    end
  end

  def full?
    if turn_count == 9
      puts "All spaces full!"
      return true
    else
      return false
    end
  end

  def draw?
    if full? & !won?
      return true
    else
      return false
    end
  end

  def over?
    if won? || draw?
      return true
    else
      return false
    end
  end

  def winner(player)
    if won?
      if combo - @xs == []
        "X"
      elsif combo - @os == []
        "O"
      end
    end
  end

  def play(board)
    while !over?(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations " + winner(board) + "!"
    elsif draw?(board)
      puts "Cat's Game!"
    else
      #do nothing
    end
  end

  play(@board)
end
