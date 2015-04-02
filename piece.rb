class Piece

  attr_accessor :color, :position, :board

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  def move_diffs
    self.color == :r ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
  end

  def king?

  end

  def maybe_promote
    self
  end

end
