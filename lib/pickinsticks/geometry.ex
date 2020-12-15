defmodule Pickinsticks.Geometry do
  alias Pickinsticks.Geometry.Rectangle
  alias Pickinsticks.Position, as: Pos

  def in_rectangle(%Pos{} = pos, %Rectangle{} = rect) do
    min = %Pos{x: rect.x, y: rect.y}
    max = %Pos{x: rect.x + rect.w, y: rect.y + rect.h}

    Pos.left_from?(pos, max) &&
      Pos.right_from?(pos, min) &&
      Pos.below?(pos, min) &&
      Pos.above?(pos, max)
  end
end
