defmodule PositionTest do
  use ExUnit.Case, async: true

  alias Pickinsticks.Position, as: Pos

  test "build position at (5,6)" do
    assert %Pos{x: 5, y: 6} = Pos.at(5, 6)
  end

  test "equality" do
    assert Pos.same?(Pos.at(1, 1), Pos.at(1, 1))
    refute Pos.same?(Pos.at(1, 4), Pos.at(1, 1))
  end

  test "comparing x" do
    assert Pos.same_x?(Pos.at(1, 2), Pos.at(1, 2))
    refute Pos.same_x?(Pos.at(1, 2), Pos.at(2, 2))
  end

  test "comparing y" do
    assert Pos.same_y?(Pos.at(1, 2), Pos.at(1, 2))
    refute Pos.same_y?(Pos.at(1, 1), Pos.at(2, 2))
  end

  test "this above that" do
    assert Pos.above?(Pos.at(1, 1), Pos.at(1, 2))
    refute Pos.above?(Pos.at(1, 2), Pos.at(1, 1))
    refute Pos.above?(Pos.at(1, 1), Pos.at(1, 1))
  end

  test "this below that" do
    assert Pos.below?(Pos.at(1, 2), Pos.at(1, 1))
    refute Pos.below?(Pos.at(1, 1), Pos.at(1, 2))
    refute Pos.below?(Pos.at(1, 1), Pos.at(1, 1))
  end

  test "this left from that" do
    assert Pos.left_from?(Pos.at(0, 0), Pos.at(1, 0))
    refute Pos.left_from?(Pos.at(1, 0), Pos.at(0, 0))
    refute Pos.left_from?(Pos.at(0, 0), Pos.at(0, 0))
  end

  test "this right from that" do
    assert Pos.right_from?(Pos.at(1, 0), Pos.at(0, 0))
    refute Pos.right_from?(Pos.at(0, 0), Pos.at(1, 0))
    refute Pos.right_from?(Pos.at(0, 0), Pos.at(0, 0))
  end
end
