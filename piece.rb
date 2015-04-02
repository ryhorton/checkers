class Piece
  attr_reader :board, :color, :type
  attr_accessor :position

  def initialize(color, type, position, board)
    # raise 'invalid color' unless [:white, :black].include?(color)
    # raise 'invalid position' unless board.valid_pos?(position)

    @color, @type, @position, @board = color, type, position, board
  end

  def symbols
    { :r => "R", :b => "B" }
  end

  def move_diffs
    if self.type == :pawn
      self.color == :r ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
    else  # self.type == :king
      [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
  end

  def maybe_promote
    if self.color == :r && self.position.first == 9
      return true
    elsif self.color == :b && self.position.first == 0
      return true
    end

    false
  end

end
