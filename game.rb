class Game






  def play

    puts "Enter coord of piece you want to move,"
    puts "e.g., 12 to start at [1, 2]:"
    from_pos = gets.chomp.split('').map(&:Integer)

    puts "Enter coord of move(s) you want to make,"
    puts "e.g., 12 to make a single move to [1, 2] or"
    puts "12,34 to make moves to [1, 2] then [3, 4]:"
    to_pos = gets.chomp.split(',').map { |el| el.split('').map(&:Integer) }



  end

  # check whether move puts piece at end of board (i.e., can become king)
  if piece.maybe_promote
    # make king
    king = Piece.new(piece.color, :king, piece.position, self)
    # put on board at old piece's position; impliedly delete old piece
    self[piece.position] = king

  end

end
