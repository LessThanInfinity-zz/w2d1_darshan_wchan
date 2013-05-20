class Board
  attr_accessor :board_size, :board

  def initialize
    @board_size = 9
    @num_of_mines = 10
    @board = Array.new(board_size, Array.new(board_size, '*'))
  end


  def display
    board.each { |row| puts row.join(' ') }
  end



end