class Board

  attr_accessor :board

  def initialize(midgame = false)
    @board = Array.new(10) { Array.new(10) }

    unless midgame
      set_up_board
    end
  end

  def [](pos)
    x, y = pos
    @board[x][y]   # allows you to do: board[pos] === board.[](pos)
  end

  def []=(pos, value)
    x, y = pos
    @board[x][y] = value  # allows you to do: self.[]=(value)
  end

  def set_up_board

    # set up red side
    board[0].count.times do |idx|
      board[0][idx] = (idx % 2 == 0 ? " " : Piece.new(:r, :pawn, [0, idx], self))
    end

    board[1].count.times do |idx|
      board[1][idx] = (idx % 2 == 1 ? " " : Piece.new(:r, :pawn, [1, idx], self))
    end

    # set up black side
    board[9].count.times do |idx|
      board[9][idx] = (idx % 2 == 1 ? " " : Piece.new(:b, :pawn, [9, idx], self))
    end

    board[8].count.times do |idx|
      board[8][idx] = (idx % 2 == 0 ? " " : Piece.new(:b, :pawn, [8, idx], self))
    end
  end

  def move

    # check whether move puts piece at end of board (i.e., can become king)
    if piece.maybe_promote
      # make king
      king = Piece.new(piece.color, :king, piece.position, self)
      # put on board at old piece's position; impliedly delete old piece
      self[piece.position] = king

    end

  end

end
