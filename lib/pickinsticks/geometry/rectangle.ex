defmodule Pickinsticks.Geometry.Rectangle do
  alias Pickinsticks.Geometry.Rectangle

  defstruct x: 0, y: 0, w: 0, h: 0

  def build(x, y, w, h), do: %Rectangle{x: x, y: y, w: w, h: h}
end
