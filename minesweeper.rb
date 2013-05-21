#!/usr/bin/env ruby

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

    else
      reveal(coord)
    end
  end

  def reveal(coord)
    queue = []
    visited = []
    queue << coord

    until queue.empty?
      p "queue is #{queue}"
      #gets

      current_position = queue.shift
      #next if !board[current_position.first][current_position.last]

      p "current_position is #{current_position.inspect}"
      p "#{check_bombs(current_position)} bomb(s) near"
      p ""

      if check_bombs(current_position) > 0
        y,x = current_position
        board[y][x] = check_bombs(current_position)

      else
        fringe_squares = surrounding(current_position) do |y, x|
          !visited.include?([y,x])
        end
        visited << current_position

        fringe_squares.each {|el| board[el.first][el.last] = '-'}

        queue += fringe_squares.select do |position|
          !visited.include?(position)
        end
        queue.uniq!
      end
      self.display
      gets
    end
  end

  def check_bombs(coord)
    # returns # of bombs
    y, x = coord
    num_of_bombs = surrounding(coord) {|y, x| mines.include?([y, x])}
    num_of_bombs.length
  end


  def surrounding(position, &blk)
    y,x = position
    result = []

    (-1..1).each do |add_to_x|
      (-1..1).each do |add_to_y|
        check_x = x + add_to_x
        check_y = y + add_to_y
        next unless (0..8).include?(check_y) && (0..8).include?(check_x)
        next if result.include?([check_y, check_x])
        result << [check_y, check_x] if blk.call(check_y, check_x)
      end
    end
    result
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

if __FILE__ == $PROGRAM_NAME
  a = Board.new
  a.display_mines
  p "input coord"
  input = gets.chomp
  input = input.split.map {|el| el.to_i}
  p input.inspect
  a.check_coord(input)
  a.display
end
