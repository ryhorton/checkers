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
      board[0][idx] = (idx % 2 == 0 ? nil : Piece.new(:r, :pawn, [0, idx], self))
    end

    board[1].count.times do |idx|
      board[1][idx] = (idx % 2 == 1 ? nil : Piece.new(:r, :pawn, [1, idx], self))
    end

    # set up black side
    board[9].count.times do |idx|
      board[9][idx] = (idx % 2 == 1 ? nil : Piece.new(:b, :pawn, [9, idx], self))
    end

    board[8].count.times do |idx|
      board[8][idx] = (idx % 2 == 0 ? nil : Piece.new(:b, :pawn, [8, idx], self))
    end
  end

  def pieces
    board.flatten.compact
  end

  def valid_pos?(pos)
    pos.all? { |i| i.between?(0,9) }
  end

  def dup
    dup = Board.new(true)
    pieces.each do |piece|
      dup[piece.position] = Piece.new(piece.color, piece.type, piece.position, dup)
    end

    dup
  end

  def inspect
    board.map do |row|
      row.map do |piece|
        piece.nil? ? ' ' : piece.type
      end.join(' ')
    end.join('\n')
  end
end

class InvalidMoveError < StandardError
end
