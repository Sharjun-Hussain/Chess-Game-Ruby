class Piece
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def valid_move?(start_row, start_col, end_row, end_col, board)
    raise NotImplementedError, "Temp"
  end
end