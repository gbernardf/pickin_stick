defmodule Pickinsticks.StickGenerator do
  alias Pickinsticks.State
  alias Pickinsticks.StickGenerator, as: Gen
  alias Pickinsticks.Position, as: Pos

  def build(%State{tiles: %{colliders: colliders}, world_bounds: wb}, sticks_count)
      when sticks_count > 0,
      do: Enum.map(1..sticks_count, fn _ -> Gen.random_stick(colliders, wb) end)

  def build(_state, _), do: []

  def random_stick(colliders, bounds) do
    maybe_pos = Pos.at(Enum.random(0..bounds.width), Enum.random(0..bounds.height))
    collide = Enum.any?(colliders, &Pos.same?(&1.position, maybe_pos))
    validate_pos(maybe_pos, colliders, bounds, collide)
  end

  def validate_pos(_pos, colliders, bounds, true = _collide), do: random_stick(colliders, bounds)
  def validate_pos(pos, _colliders, _, _), do: pos
end
