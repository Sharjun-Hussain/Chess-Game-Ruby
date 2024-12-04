require_relative 'piece'

class King < Piece
  attr_reader :color

  def initialize(color)
    @color = color  # White or Black
  end

  def valid_move?(start_row, start_col, end_row, end_col, board)
    # King moves 1 square in any direction
    row_diff = (start_row - end_row).abs
    col_diff = (start_col - end_col).abs

    # King can move 1 square horizontally, vertically, or diagonally
    if row_diff <= 1 && col_diff <= 1
      # The destination must either be empty or contain an opponent's piece
      return board[end_row][end_col] == ' ' || board[end_row][end_col].color != @color
    end

    false
  end
end
