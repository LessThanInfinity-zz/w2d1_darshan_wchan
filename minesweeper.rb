require 'set'

class Board
  attr_accessor :board_size, :board, :mines

  def initialize
    @board_size = 9
    @num_of_mines = 10
    @board = Array.new(board_size, Array.new(board_size, '*'))
    @mines = Set.new
    set_mines
    p mines
  end


  def set_mines

    @num_of_mines.times do
      x = rand(board_size - 1)
      y = rand(board_size - 1)

      mines << [y,x] unless mines.include? ( [y,x] )

    end

  end


  def display
    board.each { |row| puts row.join(' ') }

  end



end