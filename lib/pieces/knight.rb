require_relative 'piece'

class Knight < Piece
  attr_reader :color

  def initialize(color)
    @color = color  # White or Black
  end

  def valid_move?(start_row, start_col, end_row, end_col, board)
    # Check if the move is in an L-shape: 2 squares in one direction, 1 in the other
    row_diff = (start_row - end_row).abs
    col_diff = (start_col - end_col).abs

    # A knight moves 2 squares in one direction and 1 square in the other
    if (row_diff == 2 && col_diff == 1) || (row_diff == 1 && col_diff == 2)
      # The destination must either be empty or contain an opponent's piece
      return board[end_row][end_col] == ' ' || board[end_row][end_col].color != @color
    end

    false
  end
end
