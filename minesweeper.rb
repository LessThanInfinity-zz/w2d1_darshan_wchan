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
      display_mines
      return
    else


    end
  end

  def check_bombs(coord)
    # returns # of bombs
    y, x = coord
    num_of_bombs = 0

    (-1..1).each do |add_to_x|
      (-1..1).each do |add_to_y|
        check_x = x + add_to_x
        check_y = y + add_to_y

        next if [check_x, check_y] == [x,y]

        num_of_bombs += 1 if mines.include?([check_y,check_x])
      end
    end
    num_of_bombs
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