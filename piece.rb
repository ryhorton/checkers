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

  def perform_slide(to_pos)
    if valid_moves.include?(to_pos)
      board[to_pos] = self
      board[self.position] = nil
      self.position = to_pos
      return true
    end

    false
  end

  def perform_jump(to_pos)
    if valid_moves.include?(to_pos)
      board[to_pos] = self
      board[self.position] = nil
      self.position = to_pos
      # remove jumped piece
      board[(to_pos[0] - self.position[0]) / 2, (to_pos[1] - self.position[1]) / 2] = nil
      return true
    end

    false
  end

  def valid_moves
    moves = []
    move_diffs.each do |x, y|

      pos1 = [self.position[0] + x, self.position[1] + y]
      pos2 = [self.position[0] + (2 * x), self.position[1] + (2 * y)]

      if board[pos1].nil?
        moves << pos1
      elsif (board[pos1].color != self.color) && board[pos2].nil?
        moves << pos2
      end
    end

    moves
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
