require_relative 'piece'

class Bishop < Piece
  attr_reader :color

  def initialize(color)
    @color = color  # White or Black
  end

  def valid_move?(start_row, start_col, end_row, end_col, board)
    # Check if the move is diagonal (absolute row difference equals absolute column difference)
    row_diff = (start_row - end_row).abs
    col_diff = (start_col - end_col).abs

    if row_diff == col_diff
      # Check if all squares between start and end are empty
      return valid_diagonal_move?(start_row, start_col, end_row, end_col, board)
    end

    false
  end

  private

  def valid_diagonal_move?(start_row, start_col, end_row, end_col, board)
    row_step = start_row < end_row ? 1 : -1
    col_step = start_col < end_col ? 1 : -1

    current_row = start_row + row_step
    current_col = start_col + col_step

    # Ensure all squares between start and end are empty
    while current_row != end_row && current_col != end_col
      return false unless board[current_row][current_col] == ' '

      current_row += row_step
      current_col += col_step
    end

    # The destination square must either be empty or contain an opponent's piece
    board[end_row][end_col] == ' ' || board[end_row][end_col].color != @color
  end
end
