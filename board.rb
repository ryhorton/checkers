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

  def move(from_pos, to_pos)  # to_pos will be an array of coord
    raise 'there is no piece at that position' if self[from_pos].nil?

    if

    raise 'invalid move' if self[to_pos] # cannot move to an occupied space

    if valid_pos?(to_pos) && self[to_pos].nil?  # to_pos is on the board and free
      piece = self[from_pos]

# is seq itself valid?
# it makes the dup boards

      #case to_pos is one set coord

      #case mult coords
      piece.perform_slide(to_pos) || piece.perform_jump(to_pos)

      # iterate over to_pos

      # keep trying jump
      #dup board each time


    end
  end




end
