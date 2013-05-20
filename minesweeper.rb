class Board
  attr_accessor :board_size

  def initialize
    @board_size = 9
    @num_of_mines = 10
      array = Array.new(board_size, Array.new(board_size, '*'))
  end


  def display

  end



end