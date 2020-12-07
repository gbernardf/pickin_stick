defmodule Pickinsticks.StickGenerator do
  alias Pickinsticks.State
  alias Pickinsticks.StickGenerator, as: Gen
  alias Pickinsticks.Position, as: Pos

  def build(%State{tiles: %{walls: walls}, world_bounds: wb}, sticks_count) when sticks_count > 0,
    do: Enum.map(1..sticks_count, fn _ -> Gen.random_stick(walls, wb) end)

  def build(_state, _), do: []

  def random_stick(walls, bounds) do
    maybe_pos = Pos.at(Enum.random(0..bounds.width), Enum.random(0..bounds.height))
    collide = Enum.any?(walls, &Pos.same?(&1, maybe_pos))
    validate_pos(maybe_pos, walls, bounds, collide)
  end

  def validate_pos(_pos, walls, bounds, true = _collide), do: random_stick(walls, bounds)
  def validate_pos(pos, _walls, _, _), do: pos
end
