require_relative 'lib/chess_board'
require_relative 'lib/player'

# Main game loop
def play_game
  board = ChessBoard.new
  player1 = Player.new("Player 1", 'white')
  player2 = Player.new("Player 2", 'black')
  current_player = player1

  loop do
    board.display
    puts "#{current_player.name}'s (#{current_player.color}) turn. Enter move ('a1 a2'):"
    move = gets.chomp.split
    start_pos, end_pos = move


    if board.move_piece(start_pos, end_pos, current_player)
      if board.in_check?(current_player.color)
        puts "You are in check!"
      end

      # Check if the opponent is in checkmate after the move
      if board.checkmate?(current_player == player1 ? player2.color : player1.color)
        puts "Checkmate! #{current_player.name} wins!"
        break
      elsif board.in_check?(current_player == player1 ? player2.color : player1.color)
        puts "Check!"
      end

    # Switch players
    current_player = (current_player == player1) ? player2 : player1        
    end
  end
end

play_game