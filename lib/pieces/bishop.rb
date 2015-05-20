# -*- coding: utf-8 -*-

class Bishop < Piece
  include Slideable

  def valid_moves
    super
  end

  def display
    case @color
    when :black
      print "\u265D"
    when :white
      print "\u2657"
    end
  end
  #call moves(horizontal)

  def moves
    list = []
    diagonal_dirs.each { |delta| list += explore(delta) }
    list.uniq
  end

end
#
