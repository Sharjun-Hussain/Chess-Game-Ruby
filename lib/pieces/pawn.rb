require_relative 'piece'

class Pawn < Piece
  attr_reader :color

  def initialize(color)
    @color = color 
  end

  def valid_move?(start_row, start_col, end_row, end_col, board)
    direction = @color == 'white' ? 1 : -1

   
    if start_col == end_col
      return true if end_row == start_row + direction && board[end_row][end_col] == ' '
      if (@color == 'white' && start_row == 1) || (@color == 'black' && start_row == 6)
        return true if end_row == start_row + (2 * direction) && board[end_row][end_col] == ' ' && board[start_row + direction][start_col] == ' '
      end
    end

    if (start_col - end_col).abs == 1 && end_row == start_row + direction
      return true if board[end_row][end_col] != ' ' && board[end_row][end_col].color != @color
    end

    false

  end
end



