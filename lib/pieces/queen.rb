require_relative 'piece'

class Queen < Piece
  attr_reader :color

  def initialize(color)
    @color = color  # White or Black
  end

  def valid_move?(start_row, start_col, end_row, end_col, board)
    # The queen moves either like a rook (horizontally or vertically) or like a bishop (diagonally)
    if start_row == end_row
      # Horizontal movement (same row)
      return valid_horizontal_move?(start_row, start_col, end_col, board)
    elsif start_col == end_col
      # Vertical movement (same column)
      return valid_vertical_move?(start_row, start_col, end_row, board)
    elsif (start_row - end_row).abs == (start_col - end_col).abs
      # Diagonal movement
      return valid_diagonal_move?(start_row, start_col, end_row, end_col, board)
    end

    false
  end

  private

  # Use the same methods for rook's and bishop's moves
  def valid_horizontal_move?(row, start_col, end_col, board)
    # Make sure start_col and end_col are not the same
    return false if start_col == end_col

    # Determine the range of columns between the start and end columns
    col_range = if start_col < end_col
                  (start_col + 1...end_col).to_a
                else
                  (end_col + 1...start_col).to_a
                end

    # Ensure all squares between start and end are empty
    col_range.each do |col|
      return false unless board[row][col] == ' '
    end

    # Check that the destination square is either empty or has an opponent's piece
    board[row][end_col] == ' ' || board[row][end_col].color != @color
  end

  def valid_vertical_move?(start_row, col, end_row, board)
    # Make sure start_row and end_row are not the same
    return false if start_row == end_row

    # Determine the range of rows between the start and end rows
    row_range = if start_row < end_row
                  (start_row + 1...end_row).to_a
                else
                  (end_row + 1...start_row).to_a
                end

    # Ensure all squares between start and end are empty
    row_range.each do |row|
      return false unless board[row][col] == ' '
    end

    # Check that the destination square is either empty or has an opponent's piece
    board[end_row][col] == ' ' || board[end_row][col].color != @color
  end

  def valid_diagonal_move?(start_row, start_col, end_row, end_col, board)
    row_step = start_row < end_row ? 1 : -1
    col_step = start_col < end_col ? 1 : -1

    current_row = start_row + row_step
    current_col = start_col + col_step

    while current_row != end_row && current_col != end_col
      return false unless board[current_row][current_col] == ' '

      current_row += row_step
      current_col += col_step
    end

    # Check that the destination square is either empty or has an opponent's piece
    board[end_row][end_col] == ' ' || board[end_row][end_col].color != @color
  end
end
