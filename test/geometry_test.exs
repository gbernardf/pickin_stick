defmodule Pickinsticks.GeometryTest do
  use ExUnit.Case, async: true

  alias Pickinsticks.Position, as: Pos
  alias Pickinsticks.Geometry
  alias Pickinsticks.Geometry.Rectangle

  test "return true when pos is in rect" do
    assert true = Geometry.in_rectangle(Pos.at(1, 1), Rectangle.build(0, 0, 2, 2))
  end
end
