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

    elsif
      fringe_squares = surrounding(coord)  do |y, x|
        result = check_bombs([y,x]) > 0

        board[y][x] = "-" if (0..8).include?(x) && (0..8).include?(y)

        #check_coord([y,x])
        result
      end
    else


    end
  end

  def check_bombs(coord)
    # returns # of bombs
    y, x = coord
    num_of_bombs = surrounding(coord) {|y, x| mines.include?([y, x])}
    num_of_bombs.count(true)
  end


  def surrounding(position, &blk)
    y,x = position
    true_false = []

    (-1..1).each do |add_to_x|
      (-1..1).each do |add_to_y|
        check_x = x + add_to_x
        check_y = y + add_to_y

        next if [add_to_x, add_to_y] == [0,0]
        true_false << blk.call(check_y, check_x)
      end
    end
    true_false
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
