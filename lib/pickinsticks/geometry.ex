defmodule Pickinsticks.Geometry do
  alias Pickinsticks.Geometry.Rectangle
  alias Pickinsticks.Position, as: Pos

  def in_rectangle(%Pos{} = pos, %Rectangle{} = rect) do
    min = %Pos{x: rect.x, y: rect.y}
    max = %Pos{x: rect.x + rect.w, y: rect.y + rect.h}

    pos.x <= max.x &&
      pos.x >= min.x &&
      pos.y <= max.y &&
      pos.y >= min.y
  end
end
