# coding: utf-8

require_relative 'board'

class Piece
  attr_reader :board, :color, :type
  attr_accessor :position

  def initialize(color, type, position, board)
    # raise 'invalid color' unless [:white, :black].include?(color)
    # raise 'invalid position' unless board.valid_pos?(position)

    @color, @type, @position, @board = color, type, position, board
  end

  def to_s
    self.color == :r ? "◉" : "◎"
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
      jumped_pos = [(to_pos[0] - self.position[0]).abs / 2, (to_pos[1] - self.position[1]).abs / 2]
      board[jumped_pos] = nil
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

  def perform_moves!(move_seq)
    from_pos, to_pos = move_seq[0], move_seq[1]

    raise InvalidMoveError.new('invalid move') if board[from_pos].nil?
    raise InvalidMoveError.new('invalid move') if board[to_pos] # cannot move to an occupied space
    raise InvalidMoveError.new('invalid move') unless board.valid_pos?(to_pos)

    if move_seq.count == 2
      board[from_pos].perform_slide(to_pos) && return
    end

    board[from_pos].perform_jump(to_pos)

    while move_seq.count > 1
      # keep calling perform_jump
      from_pos = move_seq.shift
      to_pos = move_seq[0]

      raise InvalidMoveError.new('not on board') unless board.valid_pos?(to_pos)
      raise InvalidMoveError.new('cannot move to an occupied space') if board[to_pos]

      board[from_pos].perform_jump(to_pos)
    end
  end

  def perform_moves(move_seq)
    if valid_move_seq?(move_seq)  # will return true/false
      perform_moves!(move_seq)
    else
      raise InvalidMoveError.new('invalid move')
    end
  end

  def valid_move_seq?(move_seq)
    begin
      board.dup.perform_moves!(move_seq)
    rescue InvalidMoveError => e
      puts e.message
      return false
    else
      return true
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

class InvalidMoveError < StandardError
end
