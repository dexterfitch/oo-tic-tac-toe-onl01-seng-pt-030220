require 'pry'

class TicTacToe
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
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
      set1 = combo[0]
      set2 = combo[1]
      set3 = combo[2]

      position1 = @board[set1]
      position2 = @board[set2]
      position3 = @board[set3]

      if position1 == "X" && position2 == "X" && position3 == "X"
        return combo
      elsif position1 == "O" && position2 == "O" && position3 == "O"
        return combo
      end
    end
    return false
  end

  def full?
    if turn_count == 9
      true
    else
      false
    end
  end

  def draw?
    if full? & !won?
      true
    else
      false
    end
  end

  def over?
    if won? || draw?
      true
    else
      false
    end
  end

  def winner
    if won? == false
      nil
    else
      if @board[won?[0]] == "X"
        return "X"
      else
        return "O"
      end
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
