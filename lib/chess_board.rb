require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'

class ChessBoard
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8, ' ') }
    setup_board
  end

  def setup_board
    (0..7).each do |i|
      @board[1][i] = Pawn.new('white')
      @board[6][i] = Pawn.new('black')
    end
    @board[0][0], @board[0][7] = Rook.new('white'), Rook.new('white')
    @board[7][0], @board[7][7] = Rook.new('black'), Rook.new('black')
    @board[0][1], @board[0][6] = Knight.new('white'), Knight.new('white')
    @board[7][1], @board[7][6] = Knight.new('black'), Knight.new('black')
    @board[0][2], @board[0][5] = Bishop.new('white'), Bishop.new('white')
    @board[7][2], @board[7][5] = Bishop.new('black'), Bishop.new('black')
    @board[0][3], @board[7][3] = Queen.new('white'), Queen.new('black')
    @board[0][4], @board[7][4] = King.new('white'), King.new('black')
  end


  def in_check?(color)
    king_position = find_king(color)
    opponent_color = (color == 'white') ? 'black' : 'white'

    # Check if any opponent's piece can move to the king's position
    @board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        if piece.is_a?(Piece) && piece.color == opponent_color
          return true if piece.valid_move?(row_index, col_index, king_position[0], king_position[1], @board)
        end
      end
    end

    false
  end

  def find_king(color)
    @board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        return [row_index, col_index] if piece.is_a?(King) && piece.color == color
      end
    end
    nil
  end

  def checkmate?(color)
    return false unless in_check?(color) # If not in check, not a checkmate

    # Try every possible move to see if any can get out of check
    @board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        if piece.is_a?(Piece) && piece.color == color
          (0..7).each do |end_row|
            (0..7).each do |end_col|
              if piece.valid_move?(row_index, col_index, end_row, end_col, @board)
                # Temporarily make the move
                temp_piece = @board[end_row][end_col]
                @board[end_row][end_col] = piece
                @board[row_index][col_index] = ' '
                
                # Check if still in check
                if !in_check?(color)
                  # Undo the move and return false (not checkmate)
                  @board[row_index][col_index] = piece
                  @board[end_row][end_col] = temp_piece
                  return false
                end

                # Undo the move
                @board[row_index][col_index] = piece
                @board[end_row][end_col] = temp_piece
              end
            end
          end
        end
      end
    end

    true # No valid moves left, it's checkmate
  end
  


  def display
    puts "   a  b  c  d  e  f  g  h"
    @board.each_with_index do |row, i|
      print "#{8 - i} "
      row.each do |piece|
        if piece.is_a?(Piece)
          print "[#{piece_symbol(piece)}]"
        else
          print "[ ]"
        end
      end
      puts " #{8 - i}"
    end
    puts "   a  b  c  d  e  f  g  h"
  end

  def piece_symbol(piece)
    case piece
    when Pawn then piece.color == 'white' ? '♟' : '♙'
    when Rook then piece.color == 'white' ? '♜' : '♖'
    when Knight then piece.color == 'white' ? '♞' : '♘'
    when Bishop then piece.color == 'white' ? '♝' : '♗'
    when Queen then piece.color == 'white' ? '♛' : '♕'
    when King then piece.color == 'white' ? '♚' : '♔'
    end
  end
 

  def notation_to_index(position)
    col = position[0].ord - 'a'.ord
    row = 8 - position[1].to_i
    [row, col]
  end

  def move_piece(start_pos, end_pos, current_player)
    start_row, start_col = notation_to_index(start_pos)
    end_row, end_col = notation_to_index(end_pos)

    piece = @board[start_row][start_col]

    if piece.is_a?(Piece)
      if piece.color == current_player.color
        if piece.valid_move?(start_row, start_col, end_row, end_col, @board)
          temp_piece = @board[end_row][end_col]
          @board[end_row][end_col] = piece
          @board[start_row][start_col] = ' '

          if in_check?(current_player.color)
            # Undo the move if it places the current player in check
            @board[start_row][start_col] = piece
            @board[end_row][end_col] = temp_piece
            puts "You cannot move into check!"
            return false
          end

          return true
        else
          puts "Invalid move!"
          return false
        end
      else
        puts "You can only move your own pieces!"
        return false
      end
    else
      puts "No valid piece at the start position!"
      return false
    end
  end
end

