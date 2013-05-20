require 'set'

class Board
  attr_accessor :board_size, :board, :mines

  def initialize
    @board_size = 9
    @num_of_mines = 10
    @board = Array.new(board_size) { Array.new(board_size) {'*'} }
    @mines = Set.new
    set_mines
    p mines
  end


  def set_mines

    until mines.length == @num_of_mines
      x = rand(board_size - 1)
      y = rand(board_size - 1)
      mines << [y,x] unless mines.include?( [y,x] )
    end

  end

  def display_mines
    mines.each do |mine_pos|
      y, x = mine_pos.first, mine_pos.last
      board[y][x] = "B"
    end
    display
  end

  def display
    board.each { |row| puts row.join(' ') }
  end

  def check_coord(coord)
    if mines.include?(coord)
      puts "Game Over"

    end
  end





end

class Minesweeper
  attr_accessor :coord
  def initialize

  end

  def input
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    coord = [x, y]
  end


end