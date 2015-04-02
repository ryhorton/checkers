class Game






  def play




  end

  # check whether move puts piece at end of board (i.e., can become king)
  if piece.maybe_promote
    # make king
    king = Piece.new(piece.color, :king, piece.position, self)
    # put on board at old piece's position; impliedly delete old piece
    self[piece.position] = king

  end

end
