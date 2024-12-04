require_relative 'piece'

class Rook < Piece
  attr_reader :color

  def initialize(color)
    @color = color  # White or Black
  end

  def valid_move?(start_row, start_col, end_row, end_col, board)
    # Rook moves either horizontally (same row) or vertically (same column)
    if start_row == end_row
      # Horizontal movement (same row)
      return valid_horizontal_move?(start_row, start_col, end_col, board)
    elsif start_col == end_col
      # Vertical movement (same column)
      return valid_vertical_move?(start_row, start_col, end_row, board)
    end

    # If it's not moving in a straight line, it's an invalid move
    false
  end

  private

  # Check if horizontal movement is valid (row stays the same, only column changes)
  def valid_horizontal_move?(row, start_col, end_col, board)
    # Determine the range of columns between the start and end columns
    col_range = if start_col < end_col
                  (start_col + 1..end_col - 1).to_a
                elsif start_col > end_col
                  (end_col + 1..start_col - 1).to_a
                else
                  []  # No movement
                end

    # Ensure all columns between start and end are empty
    col_range.each do |col|
      return false unless board[row][col] == ' '  # Assuming empty squares are ' '
    end

    # The destination square must be empty or contain an opponent's piece
    board[row][end_col] == ' ' || board[row][end_col].color != @color
  end

  # Check if vertical movement is valid (column stays the same, only row changes)
  def valid_vertical_move?(start_row, col, end_row, board)
    # Determine the range of rows between the start and end rows
    row_range = if start_row < end_row
                  (start_row + 1..end_row - 1).to_a
                elsif start_row > end_row
                  (end_row + 1..start_row - 1).to_a
                else
                  []  # No movement
                end

    # Ensure all rows between start and end are empty
    row_range.each do |row|
      return false unless board[row][col] == ' '  # Assuming empty squares are ' '
    end

    # The destination square must be empty or contain an opponent's piece
    board[end_row][col] == ' ' || board[end_row][col].color != @color
  end
end
